class PlaylistVideoRelationsController < ApplicationController
  before_action :require_user
  before_action :set_playlist_video_relation, only:[:destroy]

  def create
    @playlist_video_relation = PlaylistVideoRelation.new(playlist_video_relation_params)
    @playlist_video_relation.save
    redirect_to :back
  end

  def destroy
    @playlist_video_relation.destroy
    redirect_to :back
  end

  private
    def set_playlist_video_relation
      @playlist_video_relation = PlaylistVideoRelation.find(params[:id])
    end

    def playlist_video_relation_params
      params.require(:playlist_video_relation).permit(:playlist_id, :video_id)
    end
end
