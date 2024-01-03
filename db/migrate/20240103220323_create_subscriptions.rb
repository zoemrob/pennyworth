class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :active
      t.datetime :date_unsubscribed

      t.timestamps
    end
  end
end
