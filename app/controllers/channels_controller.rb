class ChannelsController < ApplicationController
  before_action :require_user
  before_action :set_channel, only: [:show, :edit, :update, :destroy, :register]

  def index
    @channels = Channel.all
  end

  def show
  end

  def new
    @channel = Channel.new
  end

  def edit
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to @channel, notice: 'Channel was successfully created.'
    else
      render :new
    end
  end

  def update
    if @channel.update(channel_params)
      redirect_to @channel, notice: 'Channel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @channel.destroy
    redirect_to channels_url, notice: 'Channel was successfully destroyed.'
  end

  def register
    Subscription.register(params[:register].to_i, current_user, @channel)
    redirect_to :back
  end

  def subscriptions
    @channels = current_user.my_favorite_channels
    render :index
  end

  private
    def set_channel
      @channel = Channel.find(params[:id])
    end

    def channel_params
      params.require(:channel).permit(:name, :user_id)
    end
end
