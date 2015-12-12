class User < ActiveRecord::Base
  has_many :videos
  has_many :playlists
  has_many :channels
  has_many :subscriptions
  has_many :comments

  validates :name, presence:true
  validates :email, presence:true

  has_secure_password

  after_create :create_initial_channel
  after_create :create_initial_playlist
  def create_initial_channel
    self.channels.create(name: self.name, current: true)
  end

  def create_initial_playlist
    self.playlists.create(name: "お気に入り", playlist_type: Playlist.types[:favorite])
    self.playlists.create(name: "高く評価した動画", playlist_type: Playlist.types[:like])
    self.playlists.create(name: "低く評価した動画", playlist_type: Playlist.types[:dislike])
    self.playlists.create(name: "後で見る", playlist_type: Playlist.types[:later])
    self.playlists.create(name: "履歴", playlist_type: Playlist.types[:history])
  end
end
