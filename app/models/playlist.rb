class Playlist < ActiveRecord::Base
  has_many :videos, through: :video_playlists
  has_many :video_playlists

  belongs_to :user

  def self.get_see_later(user)
    Playlist.where(name: "See later", user: user).preload(:video)
  end

  def self.get_favorites(user)
    Playlist.where(name: "favorite", user: user).preload(:video)
  end

  def self.get_custom_playlists(user)
    Playlist.where.not(name: ["See later", "favorite"]).where(user: user).uniq.preload(:video)
  end

  def self.build_for_register(user, video_id)
    p = user.playlists.where(name: "XXXXX")
    see_laters = user.playlists.where(name: "See later", video_id: video_id);
    if see_laters.exists?
      # delete
      p.push(see_laters.first)
    else
      # add
      new_see_later = user.playlists.build(name: "See later", video_id: video_id)
      p.push(new_see_later)
    end

    favorites = user.playlists.where(name: "favorite", video_id: video_id);
    if favorites.exists?
      p.push(favorites.first)
    else
      new_favorite = user.playlists.build(name: "favorite", video_id: video_id)
      p.push(new_favorite)
    end

    user.playlists.where.not(name: ["See later", "favorite"]).uniq.each do |playlist|
      custom_playlists = user.playlists.where(name: playlist.name, video_id: video_id)
      if custom_playlists.exists?
        # delete
        p.push(custom_playlists.first)
      else
        # add
        new_custom_playlists = user.playlists.build(name: playlist.name, video_id: video_id)
        p.push(new_custom_playlists)
      end
    end
    return p
  end

  def find_video_by_name(user)
    ids = Playlist.where(user:user, name: self.name).pluck(:video_id)
    videos = Video.where(id: ids)
  end

  def self.new_playlist_build(user, video_id)
    user.playlists.build(video_id: video_id)
  end
end
