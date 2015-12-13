class CreatePlaylistVideoRelations < ActiveRecord::Migration
  def change
    create_table :playlist_video_relations do |t|
      t.string :video_id
      t.integer :playlist_id
      t.timestamps null: false
    end
  end
end
