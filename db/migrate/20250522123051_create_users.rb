class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :gender, null: false
      t.string :line_uid, null: false
      t.string :email
      t.string :password_digest
      t.integer :reminder_interval

      t.timestamps
    end
  end
end
