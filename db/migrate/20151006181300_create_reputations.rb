class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :status, default:0, null:false
      t.timestamps null: false
    end
  end
end
