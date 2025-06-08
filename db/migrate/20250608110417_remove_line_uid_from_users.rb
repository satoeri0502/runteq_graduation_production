class RemoveLineUidFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :line_uid, :string
  end
end
