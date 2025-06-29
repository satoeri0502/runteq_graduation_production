# app/controllers/medicines_wizard_controller.rb
require "ostruct"

class MedicinesWizardController < ApplicationController
  include Wicked::Wizard

  # Wizard のステップ順
  steps :name, :dosetiming, :remaining, :alert_times, :confirm

  before_action :require_login  # ログイン必須

  def show
    session[:wizard] ||= { "medicine" => {}, "dosetiming" => {} }

    # 各ステップ用に resource を準備
    case step
    when :name
      @medicine = current_user.medicines.new(session[:wizard]["medicine"])
    when :dosetiming, :remaining, :alert_times
      # dosetiming情報は OpenStruct に詰め替えて扱う
      @dosetiming = OpenStruct.new(session[:wizard]["dosetiming"])
    when :confirm
      # 確認画面では Dosetiming インスタンス群を返す
      @medicine = current_user.medicines.new(session[:wizard]["medicine"])
      @dosetiming_records = session[:wizard]["dosetiming"]["dose_times"].each_with_index.map do |time_cat, idx|
        Dosetiming.new(
          dose_time:     time_cat,
          dose_timing:   session[:wizard]["dosetiming"]["dose_timing"],
          reminder_time: session[:wizard]["dosetiming"]["reminder_times"][idx]
        )
      end
    end

    render_wizard
  end

  def update
    session[:wizard] ||= {}

    case step
    when :name
      # ステップ①：おくすり名入力
      session[:wizard]["medicine"] = params.require(:medicine)
                                        .permit(:name)
                                        .to_h

    when :dosetiming
      # ステップ②：飲む時間帯、飲むタイミング、１回あたり服用数入力
      # dose_times: ["morning","evening"] のように複数選択可能
      session[:wizard]["dosetiming"] = params.require(:dosetiming)
                                            .permit(:dose_timing, :pills_per_dose, dose_times: [])
                                            .to_h

    when :remaining
      # ステップ③：在庫数入力
      session[:wizard]["medicine"].merge!(  # merge!で既に入っているmedicineに今回のデータを追加
        params.require(:medicine)
              .permit(:stock_count)
              .to_h
      )

      # 整数にして扱いやすく
      stock_count = session[:wizard]["medicine"]["stock_count"].to_i

      # 前ステップで集めた情報から「１か月あたり消費量」を計算
      # dose_per_day = session[:wizard]["dosetiming"]["dose_times"].size *
      #               session[:wizard]["dosetiming"]["pills_per_dose"].to_i

      # 今月の日数を取得
      # days_in_month = Date.today.end_of_month.day

      # stock_alert_count を自動計算
      # alert_count = stock_count - (days_in_month * dose_per_day)
      alert_count = 0   # MVPリリースでは数か月前通知は実装しないので0に設定

      # マージ実行
      session[:wizard]["medicine"].merge!(
        "stock_count"       => stock_count,
        "stock_alert_count" => alert_count,  # 自動セット
        "stock_alert_month" => 0             # デフォルト off
      )

    when :alert_times
      # ステップ④：各 dose_times ごとの通知時刻
      reminder_times = params.require(:dosetiming)
                             .permit(reminder_times: [])[:reminder_times]
      session[:wizard]["dosetiming"].merge!(
        "reminder_times" => reminder_times
      )
    end

    if step == steps.last
      # 最終ステップ：まとめて登録 → セッションクリア → 完了画面 or 一覧へ
      create_records_from(session[:wizard])
      session.delete(:wizard)
      redirect_to finish_wizard_path, success: "おくすりが登録されました！"
    else
      # 次のステップの URL にリダイレクト
      redirect_to next_wizard_path
    end
  end

  private

  # DB登録。複数モデルをトランザクションでまとめる
  def create_records_from(data)
    ActiveRecord::Base.transaction do
      # Medicine 作成
      med = current_user.medicines.create!(
        name:             data["medicine"]["name"],                       # くすり名
        dose_per_day:     data["dosetiming"]["dose_times"].size,          # 一日に飲む回数
        pills_per_dose:   data["dosetiming"]["pills_per_dose"].to_i,      # 1回に飲む錠数
        stock_count:      data["medicine"]["stock_count"].to_i,           # 在庫数
        stock_alert_count: data["medicine"]["stock_alert_count"].to_i,    # 補充通知の個数デッドライン
        stock_alert_month: data["medicine"]["stock_alert_month"].to_i     # 補充通知の月デッドライン
        # ※必要なら image もここでセット
      )

      # Dosetiming を dose_times ごとに作成
      data["dosetiming"]["dose_times"].each_with_index do |time_cat, idx|
        med.dosetimings.create!(
          dose_time:     time_cat,
          dose_timing:   data["dosetiming"]["dose_timing"],
          reminder_time: data["dosetiming"]["reminder_times"][idx]
        )
      end

      med
    end
  end

  # 完了後の遷移先（一覧ページなど）
  def finish_wizard_path
    medicines_path
  end
end
