class UsersController < ApplicationController
  before_action :require_user, except: [:create, :new]
  before_action :set_user, only: [:show, :update, :destroy, :home, :edit]

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

  private
    def set_user
      logger.debug(params[:format])
      unless params[:format].blank?
        logger.debug("not current_user")
        @user = User.find(params[:format])
      else
        logger.debug("current_user")
        @user = current_user
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, channels_attributes: [:id, :name])
    end
end
