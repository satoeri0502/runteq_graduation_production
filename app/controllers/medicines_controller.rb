class MedicinesController < ApplicationController
  # おくすり一覧画面
  def index
    @medicines = current_user.medicines
  end

  def destroy
    medicine = current_user.medicines.find(params[:id])
    medicine.destroy!
    redirect_to medicines_path, success: "おくすりを1件削除しました！"
  end

  private

  def medicine_params
    params.require(:medicine).permit(:name, :dose_per_day, :pills_per_dose, :stock_count, :stock_alert_count, :stock_alert_month)
  end
end
