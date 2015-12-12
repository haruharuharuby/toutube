class PlaylistsController < ApplicationController
  before_action :require_user
  before_action :set_playlist, only: [:show, :destroy]

  def index
    @playlists = current_user.playlist.build_for_register(current_user, params[:video])
    @new_playlist = Playlist.new_playlist_build(current_user, params[:video])
  end

  def show
    @videos = @playlist.find_video_by_name(current_user)
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.save

    redirect_to :back
  end

  def destroy
    @playlist.destroy

    redirect_to :back
  end

  private
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params.require(:playlist).permit(:name, :user_id, :video_id)
    end
end
