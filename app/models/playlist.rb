class Playlist < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  def self.see_lateres(user)
    Playlist.where(name: "See later", user_id: user)
  end

  def favorites(user)
    Playlist.where(name: "favorite", user_id: user)
  end

  def custom_playlists(user)
    Playlist.where.not(name: ["See later", "favorite"], user_id: user)
  end

end
