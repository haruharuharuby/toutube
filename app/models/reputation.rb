class Reputation < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  enum status: { neither:0, like:1, dislike:2 }

  def self.add(user, video, status)
    r = Reputation.find_or_initialize_by(user_id: user, video_id: video)
    if r.new_record?
      r.user = user
      r.video = video
    end

    r.status = status
    r.save
  end

end
