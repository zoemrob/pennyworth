class AddModelToPrompt < ActiveRecord::Migration[7.1]
  def change
    add_column :prompts, :model, :string
  end
end
