class PlaylistsController < ApplicationController
  before_action :require_user

  def index
    @playlists = current_user.playlists.where(name: "XXXXX")
    see_laters = current_user.playlists.where(name: "See later", video_id: params[:video]);
    if see_laters.exists?
      # delete
      @playlists.push(see_laters.first)
    else
      # add
      new_see_later = current_user.playlists.build(name: "See later", video_id: params[:video])
      @playlists.push(new_see_later)
    end

    favorites = current_user.playlists.where(name: "favorite", video_id: params[:video]);
    if favorites.exists?
      @playlists.push(favorites.first)
    else
      new_favorite = current_user.playlists.build(name: "favorite", video_id: params[:video])
      @playlists.push(new_favorite)
    end

    current_user.playlists.where.not(name: ["See later", "favorite"]).uniq.each do |p|
      custom_playlists = current_user.playlists.where(name: p.name, video_id: params[:video])
      if custom_playlists.exists?
        # delete
        @playlists.push(custom_playlists.first)
      else
        # add
        new_custom_playlists = current_user.playlists.build(name: p.name, video_id: params[:video])
        @playlists.push(new_custom_playlists)
      end
    end

    @new_playlist = current_user.playlists.build(video_id: params[:video])
  end

  def show
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.save

    redirect_to :back
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    redirect_to :back

  end

  private
    def playlist_params
      params.require(:playlist).permit(:name, :user_id, :video_id)
    end
end
