class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  def register(flg)
    if flg == 1
      s = Subscription.new
      s.user_id = current_user.id
      s.channel_id = @channel.id
      s.save
    else
      Subscription.where(user_id:current_user, channel_id:@channel).first.destroy
    end
  end
end
