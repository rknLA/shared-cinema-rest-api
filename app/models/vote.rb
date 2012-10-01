class Vote < ActiveRecord::Base
  attr_accessible :video_id, :user_id

  belongs_to :submitted_video
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :video_id }

end
