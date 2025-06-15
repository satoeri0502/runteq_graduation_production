class ChangeColumnDefaultToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :age, from: nil, to: "0"
    change_column_default :users, :gender, from: nil, to: "Not known"
  end
end
