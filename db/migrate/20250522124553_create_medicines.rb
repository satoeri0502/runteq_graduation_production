class CreateMedicines < ActiveRecord::Migration[8.0]
  def change
    create_table :medicines do |t|
      t.string :name, null: false
      t.integer :dose_per_day, null: false
      t.integer :pills_per_dose, null: false
      t.integer :stock_count, null: false
      t.integer :stock_alert_count, null: false
      t.integer :stock_alert_month, null: false
      t.string :medicine_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
