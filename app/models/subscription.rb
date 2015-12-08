class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  def self.register(flg, user, channel)
    if flg == 1
      s = Subscription.new
      s.user = user
      s.channel = channel
      s.save
    else
      Subscription.where(user:user, channel:channel).first.destroy
    end
  end

end
