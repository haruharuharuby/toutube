class SubscriptionsController < ApplicationController
  before_action :require_user, only:[:index, :update, :create, :destroy]
  before_action :set_subscription, only:[:update, :destroy]

  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    @subscription = current_user.subscriptions.build(channel: Channel.find(params[:channel]))
    @subscription.save
    redirect_to :back
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
