class SubmittedVideo < ActiveRecord::Base
  attr_accessible :youtube_video_id, :user_id, :started_at, :finished_at

  has_many :votes, :foreign_key => 'video_id'


  def self.add_to_queue(params)
    existing = SubmittedVideo.where(:youtube_video_id => params[:youtube_video_id], :finished_at => nil)
    if existing.empty?
      vid = self.create(:youtube_video_id => params[:youtube_video_id],
                        :user_id => params[:user_id])
      vid.upvoted_by_user(params[:user_id])
    else
      vid = self.new
      vid.errors[:base] << "Video is already in queue."
      vid
    end
  end

  def upvoted_by_user(user_id)
    v = self.votes.create(:video_id => self.id,
                      :user_id => user_id)
    if v.valid?
      self.upvotes += 1
      self.save
    end
    v
  end

  def unvote_by_user(user_id)
    v = self.votes.where(:user_id => user_id).first
    if v
      v.destroy
      self.upvotes -= 1
      self.save
    end
    true
  end


end
