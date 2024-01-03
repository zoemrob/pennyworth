class CreateNewsAudios < ActiveRecord::Migration[7.1]
  def change
    create_table :news_audios do |t|
      t.references :news, null: false, foreign_key: true
      t.string :filename

      t.timestamps
    end
  end
end
