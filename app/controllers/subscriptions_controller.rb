class SubscriptionsController < ApplicationController
  before_action :require_user, only:[:index, :update, :create, :destroy]
  before_action :set_subscription, only:[:update, :destroy]

  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    channel = Channel.find(params[:channel])
    if current_user.channels.exists?(channel)
      redirect_to :back, notice: '自分のチャンネルは登録できません。'
    else
      @subscription = current_user.subscriptions.build(channel: channel)
      @subscription.save
      redirect_to :back
    end
  end

  def destroy
    @subscription.destroy
    redirect_to :back
  end

  private
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end
end
