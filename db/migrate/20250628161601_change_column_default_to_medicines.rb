class ChangeColumnDefaultToMedicines < ActiveRecord::Migration[8.0]
  def change
    change_column_default :medicines, :stock_alert_month, from: nil, to: "0"
    change_column_default :medicines, :stock_alert_count, from: nil, to: "0"
  end
end
