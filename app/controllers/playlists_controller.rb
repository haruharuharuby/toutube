class PlaylistsController < ApplicationController
  before_action :require_user

  def index
    @playlists = current_user.playlists.uniq

  end

end
