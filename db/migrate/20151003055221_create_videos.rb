class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :uri
      t.integer :user_id
      t.integer :channel_id
      t.integer :likes, null: false, default: 0
      t.integer :dislikes, null: false, default: 0
      t.integer :view_count, null: false, default: 0
      t.timestamps null: false
    end
  end
end
