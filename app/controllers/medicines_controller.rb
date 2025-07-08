class MedicinesController < ApplicationController
  before_action :require_login
  before_action :set_medicine, only: [ :edit, :update, :destroy ]

  # おくすり一覧画面
  def index
    @medicines = current_user.medicines
  end

  def edit
    # 既存の服用時間帯がなければ最低１行分 build しておく
    @medicine.dosetimings.build if @medicine.dosetimings.empty?
  end

  def update
    if @medicine.update(medicine_params)
      ReminderScheduler.call(user: current_user)
      redirect_to medicines_path, success: "おくすり情報を更新しました！"
    else
      # 入力エラーなら同じ画面へ戻してエラーメッセージを表示
      render :edit
    end
  end

  def destroy
    medicine = current_user.medicines.find(params[:id])
    medicine.destroy!
    redirect_to medicines_path, success: "おくすりを1件削除しました！"
  end

  private

  def set_medicine
    @medicine = current_user.medicines.find(params[:id])
  end

  def medicine_params
    params.require(:medicine).permit(
      :name,
      :stock_count,
      :pills_per_dose,
      :dose_per_day,
      # 必要なら dose_per_day, stock_alert_* も
      dosetimings_attributes: [
        :id,
        :dose_time,
        :dose_timing,
        :reminder_time,
        :_destroy   # チェックボックス等で削除を可能に
      ]
    )
  end
end
