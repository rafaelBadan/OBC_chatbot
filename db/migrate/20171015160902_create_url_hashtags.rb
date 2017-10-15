class CreateUrlHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :url_hashtags do |t|
      t.integer :url_id
      t.integer :hashtag_id
    end
  end
end
