class VideosController < ApplicationController
  before_action :require_user, only: [:new, :reputate, :create, :add_playlist, :delete_playlist]
  before_action :set_video, except: [:index, :search, :new, :create]

  def index
    @videos = Video.all
  end

  def show
    @video.increment!(:view_count)
  end

  def new
    @video = current_user.channels.current_channel.videos.build
  end

  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: '動画を投稿しました。'
    else
      render :new
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_url, notice: '動画を削除しました。'
  end

  def search
    @videos = Video.search(params[:key])
    render :index
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :description, :uri, :channel_id, commen_attributes:[:id])
    end
end
