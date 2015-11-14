class Playlist < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  def self.see_lateres(user)
    Playlist.where(name: "See later", user_id: user).uniq.preload(:video)
  end

  def self.favorites(user)
    Playlist.where(name: "favorite", user_id: user).uniq.preload(:video)
  end

  def self.custom_playlists(user)
    Playlist.where.not(name: ["See later", "favorite"], user_id: user).uniq.preload(:video)
  end

  def self.build_for_register(user)
    p = user.playlists.where(name: "XXXXX")
    see_laters = user.playlists.where(name: "See later", video_id: params[:video]);
    if see_laters.exists?
      # delete
      p.push(see_laters.first)
    else
      # add
      new_see_later = user.playlists.build(name: "See later", video_id: params[:video])
      p.push(new_see_later)
    end

    favorites = user.playlists.where(name: "favorite", video_id: params[:video]);
    if favorites.exists?
      p.push(favorites.first)
    else
      new_favorite = user.playlists.build(name: "favorite", video_id: params[:video])
      p.push(new_favorite)
    end

    user.playlists.where.not(name: ["See later", "favorite"]).uniq.each do |p|
      custom_playlists = user.playlists.where(name: p.name, video_id: params[:video])
      if custom_playlists.exists?
        # delete
        p.push(custom_playlists.first)
      else
        # add
        new_custom_playlists = user.playlists.build(name: p.name, video_id: params[:video])
        p.push(new_custom_playlists)
      end
    end
    return p
  end

  def self.new_playlist_build(user)
    user.playlists.build(video_id: params[:video])
  end

  def aggregate(user)
    Playlist.where(name: self.name, user_id: user)
  end
end
