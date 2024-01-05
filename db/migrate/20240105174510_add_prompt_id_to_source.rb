class AddPromptIdToSource < ActiveRecord::Migration[7.1]
  def change
    add_reference :sources, :prompt, foreign_key: true
  end
end
