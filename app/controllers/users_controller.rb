class UsersController < ApplicationController
  before_action :require_user, only: [:show, :subscribe]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :home, :videos, :playlists, :channels, :description]

  def index
    @users = User.all
  end

  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def home
    render :home
  end

  def videos
    render :videos
  end

  def playlists
    @see_lateres = Playlist.see_lateres(@user)
    @favorites = Playlist.favorites(@user)
    @custom_playlists = Playlist.custom_playlists(@user)
    @likes = @user.reputations.where(status: Reputation.statuses[:like]).preload(:video)
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
