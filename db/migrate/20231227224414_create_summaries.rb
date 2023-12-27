class CreateSummaries < ActiveRecord::Migration[7.1]
  def change
    create_table :summaries do |t|
      t.text :template

      t.timestamps
    end
  end
end
