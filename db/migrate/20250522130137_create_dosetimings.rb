class CreateDosetimings < ActiveRecord::Migration[8.0]
  def change
    create_table :dosetimings do |t|
      t.string :dose_time, null: false
      t.string :dose_timing, null: false
      t.time :reminder_time, null: false
      t.references :medicine, foreign_key: true

      t.timestamps
    end
  end
end
