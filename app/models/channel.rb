class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :videos

  def already_registered?(user)
    Subscription.where(user_id: user, channel_id:self).exists?
  end

  scope :current, -> { where(current: true).uniq.first }
end
