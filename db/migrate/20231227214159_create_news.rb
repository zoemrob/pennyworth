class CreateNews < ActiveRecord::Migration[7.1]
  def change
    create_table :news do |t|
      t.integer :user_id
      t.text :body
      t.datetime :date

      t.timestamps
    end
  end
end
