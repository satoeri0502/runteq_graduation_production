class AddIndexUidToUsers < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :uid, unique: true
  end
end
