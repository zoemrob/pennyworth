class RemoveDateFromNews < ActiveRecord::Migration[7.1]
  def change
    remove_column :news, :date
  end
end
