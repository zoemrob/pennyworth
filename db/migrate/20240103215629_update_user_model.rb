class UpdateUserModel < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :password
    remove_column :users, :phone
    add_column :users, :honorific, :string
  end
end
