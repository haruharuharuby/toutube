class ChannelsController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :set_channel, only: [:show, :destroy, :register, :change]

  def show
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to :back, notice: 'Channel was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @channel.destroy
    redirect_to channels_url, notice: 'Channel was successfully destroyed.'
  end

  def register
    if current_user.my_channel?(@channel)
      redirect_to :back, notice: 'Can not register your channel'
    else
      Subscription.register(params[:register].to_i, current_user, @channel)
      redirect_to :back, notice: 'This channel is registered'
    end
  end

  private
    def set_channel
      @channel = Channel.find(params[:id])
    end

    def channel_params
      params.require(:channel).permit(:name, :user_id)
    end
end
