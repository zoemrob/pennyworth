class AddUserIdRelation < ActiveRecord::Migration[7.1]
  def change
    change_column :news, :user_id, :integer
    add_foreign_key :news, :users, column: :user_id
  end
end
