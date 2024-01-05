class AddSummaryToSource < ActiveRecord::Migration[7.1]
  def change
    add_column :sources, :summary, :text
  end
end
