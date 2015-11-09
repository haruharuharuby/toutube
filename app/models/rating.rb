class Rating < ActiveRecord::Base
  belongs_to :video

  def update
    self.likes = Reputation.where(video_id:self.video_id, status: Reputation.statuses[:like]).count
    self.dislikes = Reputation.where(video_id:self.video_id, status: Reputation.statuses[:dislike]).count
    self.save
  end

  def up
    self.increment!(:interactions)
  end
end
