class VideosController < ApplicationController
  before_action :require_user, only: [:new, :reputate, :create]
  before_action :set_video, except: [:index, :search, :new, :create]

  def index
    @videos = Video.all
  end

  def show
  end

  def new
    @video = current_user.channels.current_channel.videos.build
  end

  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_url, notice: 'Video was successfully destroyed.'
  end

  def search
    @videos = Video.search(params[:search_keyword])
    render :index
  end

  def reputate
    if current_user.my_video?(@video)
      redirect_to @video, notice: 'Can not add reputatation your video'
    else
      # Reputation.add(current_user, @video, params[:status].to_i)
      @video.reputate(current_user, params[:status])
      redirect_to @video, notice: 'Reputated this video'
    end
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :description, :uri, :channel_id, commen_attributes:[:id])
    end
end
