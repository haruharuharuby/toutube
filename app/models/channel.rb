class Channel < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  has_many :subscriptions

  scope :current_channel, -> { where(current: true).uniq.first }

  def set_current
    old_channel = Channel.current_channel
    old_channel.current = false
    old_channel.save
    self.current = true
    self.save
  end
end
