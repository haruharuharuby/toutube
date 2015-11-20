class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  has_one :rating
  accepts_nested_attributes_for :rating
  has_many :playlists, through: :video_playlists
  has_many :video_playlists
  has_many :followed_users, through: :palylists, source: :user
  has_many :reputations
  has_many :reputated_users, through: :reputations, source: :user
  has_many :comments

  attr_accessor :like, :dislike
  mount_uploader :uri, MyvideoUploader

  scope :search, -> (key) {
    where('title like ?', "%#{key}%")
  }

  # video 作成時に Raging モデルも一緒に作っておくと良い
  def set_rating
    if self.rating
      self.rating.up
    else
      self.create_rating
      # r = Rating.new
      # r.video_id = self.id
      # r.save
    end
  end

  def self.recommends
    Video.all
  end

  def reputate(user, status)
    reputation = self.reputations.find_or_initialize_by(user: user)
    reputation.status = status
    reputation.save
  end
end
