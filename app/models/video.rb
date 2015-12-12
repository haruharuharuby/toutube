class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  has_many :playlists, through: :playlist_video_relations
  has_many :playlist_video_relations
  has_many :comments

  mount_uploader :uri, MyvideoUploader

  scope :search, -> (key) {
    where('title like ?', "%#{key}%")
  }

  def self.recommends
    Video.all
  end

end
