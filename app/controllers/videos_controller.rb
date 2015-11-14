class VideosController < ApplicationController
  before_action :require_user, only: [:new, :reputate]
  before_action :set_video, except: [:index, :search, :new, :create]

  def index
    @videos = Video.all
  end

  def show
    @video.set_rating
    @video.reload
  end

  def new
    @video = current_user.channels.current.videos.build
  end

  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  def update
    if @video.update(video_params)
      redirect_to @video, notice: 'Video was successfully updated.'
    else
      render :edit
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
    Reputation.add(current_user, @video, params[:status].to_i)
    @video.rating.update
    redirect_to @video
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :description, :uri, :channel_id, commen_attributes:[:id])
    end
end
