class UsersController < ApplicationController
  before_action :require_user, except: [:create, :new]
  before_action :set_user, only: [:show, :update, :destroy, :home, :videos, :playlists, :channels, :description]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
  end

  def videos
  end

  def playlists
  end

  def channels
  end

  def description
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, channels_attributes: [:id, :name])
    end
end
