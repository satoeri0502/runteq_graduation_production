class CreateFamilymembers < ActiveRecord::Migration[8.0]
  def change
    create_table :familymembers do |t|
      t.string :name, null: false
      t.string :relationship, null: false
      t.string :line_uid, null: false
      t.datetime :invited_at, null: false
      t.boolean :accepted, null: false, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
