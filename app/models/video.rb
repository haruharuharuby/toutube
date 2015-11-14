class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  has_one :rating
  accepts_nested_attributes_for :rating
  has_many :playlists
  has_many :followed_users, through: :palylists, source: :user
  has_many :reputations
  has_many :reputated_users, through: :reputations, source: :user
  has_many :comments
  accepts_nested_attributes_for :comments

  attr_accessor :like, :dislike
  mount_uploader :uri, MyvideoUploader

  def self.search(key)
    return Video.where("title like ?", "%#{key}%")
  end

  def set_rating
    if self.rating
      self.rating.up()
    else
      r = Rating.new
      r.video_id = self.id
      r.save
    end
  end

  def set_channel(channel)
    self.channel = channel
  end
end
