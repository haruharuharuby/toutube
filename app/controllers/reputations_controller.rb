class ReputationsController < ApplicationController
  before_action :require_user
  before_action :set_reputation, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    @reputation.status = Reputation.statuses[params[:status]]
    @reputation.save
    redirect_to :back
  end

  def destroy
  end

private
  def set_reputation
    @reputation = Reputation.find_or_initialize_by(user_id: params[user_id], video_id: params[:video_id])
  end

  def reputation_params
    params.require(:reputation).permit(:user_id, :video_id, :status)
  end
end
