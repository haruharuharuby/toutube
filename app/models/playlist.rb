class Playlist < ActiveRecord::Base
  has_many :videos, through: :playlist_video_relations
  has_many :playlist_video_relations

  enum playlist_type: %i(none, like, dislike, later, favorite, other)

  belongs_to :user

end
