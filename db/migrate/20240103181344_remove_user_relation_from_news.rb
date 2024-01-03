class RemoveUserRelationFromNews < ActiveRecord::Migration[7.1]
  def change
    remove_reference :news, :user, foreign_key: true
  end
end
