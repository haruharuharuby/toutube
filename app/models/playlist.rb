class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :videos, through: :playlist_video_relations
  has_many :playlist_video_relations

  enum type: [:like, :dislike, :later, :favorite, :history, :other]

  def build_relation(video)
    self.playlist_video_relations.build(video: video)
  end

  def video_relation(video)
    self.playlist_video_relations.where(video: video).first
  end

  def already?(video)
    self.playlist_video_relations.where(video: video).exists?
  end

  def self.operatable_lists
    self.where(playlist_type: [2,3,5])
  end

  def self.get(playlist_type)
    self.where(playlist_type: playlist_type).first
  end

  def self.like
    self.where(playlist_type: Playlist.types[:like]).first
  end

  def self.dislike
    return self.where(playlist_type: Playlist.types[:dislike]).first
  end
end
