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

  def like?(user)
    if user
      user_playlist_like = user.playlists.where(playlist_type: Playlist.types[:like])
      return self.playlists.exists?(user_playlist_like)
    else
      false
    end
  end

  def dislike?(user)
    if user
      user_playlist_dislike = user.playlists.where(playlist_type: Playlist.types[:dislike])
      return self.playlists.exists?(user_playlist_dislike)
    else
      false
    end
  end

  def new_playlist(user, type)
    playlist = Playlist.where(user: user, playlist_type: type).first
    return PlaylistVideoRelation.new(playlist: playlist, video: self)
  end

  def get_playlist(user, type)
    playlist = Playlist.where(user: user, playlist_type: type).first
    return PlaylistVideoRelation.where(playlist: playlist, video: self).first
  end

  def count_likes
    playlist_like = self.playlists.like
    return self.playlist_video_relations.where(playlist: playlist_like).count
  end

  def count_dislikes
    playlist_dislike = self.playlists.dislike
    return self.playlist_video_relations.where(playlist: playlist_dislike).count
  end

  def self.recommends
    Video.all
  end

end
