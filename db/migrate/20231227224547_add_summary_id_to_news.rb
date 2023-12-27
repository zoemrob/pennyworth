class AddSummaryIdToNews < ActiveRecord::Migration[7.1]
  def change
    add_column :news, :summary_id, :integer
    add_foreign_key :news, :summaries
  end
end
