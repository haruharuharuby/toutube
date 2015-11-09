class User < ActiveRecord::Base
  has_many :videos
  has_many :playlists
  has_many :my_playlists, through: :playlists, source: :video
  has_many :channels
  has_many :subscriptions
  has_many :my_favorite_channels, through: :subscriptions, source: :channel
  has_many :reputations
  has_many :my_reputations, through: :reputations, source: :video

  validates :name, presence:true
  validates :email, presence:true

  has_secure_password
  
end
