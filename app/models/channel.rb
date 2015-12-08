class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  has_many :subscriptions

  def already_registered?(user)
    Subscription.where(user_id: user, channel_id:self).exists?
  end

  def set_current(user)
    user.channels.update_all("current = false")
    self.current = true
  end

  scope :current_channel, -> { where(current: true).uniq.first }
end
