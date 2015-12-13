class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :videos, through: :playlist_video_relations
  has_many :playlist_video_relations

  enum type: [:like, :dislike, :later, :favorite, :history, :other]

  def already?(video)
    self.playlist_video_relations.where(video: video).exists?
  end

  def self.select_for_playlist_add
    return self.where(playlist_type: [2,3,5])
  end

  def self.like
    return self.where(playlist_type: Playlist.types[:like]).first
  end

  def self.dislike
    return self.where(playlist_type: Playlist.types[:dislike]).first
  end
end
