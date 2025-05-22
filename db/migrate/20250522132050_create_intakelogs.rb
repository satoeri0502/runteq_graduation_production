class CreateIntakelogs < ActiveRecord::Migration[8.0]
  def change
    create_table :intakelogs do |t|
      t.time :scheduled_at, null: false
      t.time :taken_at
      t.integer :status, null: false, default: 0
      t.references :user, foreign_key: true
      t.references :medicine, foreign_key: true
      t.references :dosetiming, foreign_key: true

      t.timestamps
    end
  end
end
