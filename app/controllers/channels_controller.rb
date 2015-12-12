class ChannelsController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :set_channel, only: [:show, :destroy, :register, :update]

  def index
    @channels = Channel.all
  end

  def show
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)
    @channel.save
    redirect_to :back, notice: 'チャンネルを作成しました。'
  end

  def update
    @channel.set_current
    redirect_to :back, notice: 'チャンネルを変更しました。'
  end

  def destroy
    @channel.destroy
    redirect_to channels_url, notice: 'Channel was successfully destroyed.'
  end

  private
    def set_channel
      @channel = Channel.find(params[:id])
    end

    def channel_params
      params.require(:channel).permit(:name, :user_id, :current)
    end
end
