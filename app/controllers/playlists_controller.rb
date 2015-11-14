class PlaylistsController < ApplicationController
  before_action :require_user

  def index
    @playlists = Playlist.build_for_register(user)
    @new_playlist = Playlist.new_playlist_build(user)
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
