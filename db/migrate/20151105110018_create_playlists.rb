class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string  :name
      t.integer :plylist_type, null: false, default: 0
      t.integer :user_id
      t.integer :video_id
      t.timestamps null: false
    end
  end
end
