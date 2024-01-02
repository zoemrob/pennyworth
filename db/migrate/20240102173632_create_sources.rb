class CreateSources < ActiveRecord::Migration[7.1]
  def change
    create_table :sources do |t|
      t.string :site_url
      t.string :article_url
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
