class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :uri
      t.integer :good
      t.integer :bad
      t.integer :interactions
      t.integer :channel_id
      t.timestamps null: false
    end
  end
end
