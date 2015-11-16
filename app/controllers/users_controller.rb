class UsersController < ApplicationController
  before_action :require_user, except: [:create, :new]
  before_action :set_user, only: [:show, :update, :destroy, :home, :videos, :playlists, :channels, :description]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    c = @user.channels.build(name: @user.name, current: true)
    if @user.save && c.save
      session[:user_id] = @user.id
      redirect_to :root
    else
      redirect_to :root
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def home
    render :home
  end

  def videos
    render :videos
  end

  def playlists
    @see_lateres = Playlist.get_see_later(@user)
    @favorites = Playlist.get_see_later(@user)
    @custom_playlists = Playlist.get_custom_playlists(@user)
    @likes = @user.like_videos
    render :playlists
  end

  def channels
    render :channels
  end

  def description
    render :description
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, channels_attributes: [:id, :name])
    end
end
