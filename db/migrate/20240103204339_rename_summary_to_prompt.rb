class RenameSummaryToPrompt < ActiveRecord::Migration[7.1]
  def change
    rename_table :summaries, :prompts
    rename_column :news, :summary_id, :prompt_id
  end
end
