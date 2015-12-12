class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :videos, through: :playlist_video_relations
  has_many :playlist_video_relations

  enum type: [:like, :dislike, :later, :favorite, :history, :other]



end
