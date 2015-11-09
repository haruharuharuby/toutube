class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :likes, default:0, null: false
      t.integer :dislikes, default:0, null: false
      t.integer :neigher, default:0, null: false
      t.integer :interactions, default: 0, null: false
      t.integer :video_id

      t.timestamps null: false
    end
  end
end
