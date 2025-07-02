class AddLineUserIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :line_user_id, :string
  end
end
