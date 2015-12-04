class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to home_user_url
    else
      redirect_to videos_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end
