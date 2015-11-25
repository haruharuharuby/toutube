class User < ActiveRecord::Base
  has_many :videos
  has_many :playlists
  has_many :channels
  has_many :subscriptions
  has_many :my_favorite_channels, through: :subscriptions, source: :channel
  has_many :reputations
  has_many :my_reputations, through: :reputations, source: :video
  has_many :comments

  validates :name, presence:true
  validates :email, presence:true

  has_secure_password

  def like_videos
    self.reputations.where(status: Reputation.statuses[:like]).preload(:video)
  end

  def my_video?(video)
    self.videos.exists?(video)
  end

  def my_channel?(channel)
    self.channels.exists?(channel)
  end

  after_create :create_initial_channel
  def create_initial_channel
    self.channels.create(name: self.name, current: true)
  end
end
