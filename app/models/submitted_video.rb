class SubmittedVideo < ActiveRecord::Base
  attr_accessible :youtube_video_id, :user_id, :started_at, :finished_at


  def self.add_to_queue(params)
    existing = SubmittedVideo.where(:youtube_video_id => params[:youtube_video_id], :finished_at => nil)
    if existing.empty?
      vid = self.create(:youtube_video_id => params[:youtube_video_id],
                        :user_id => params[:user_id])
    else
      vid = self.new
      vid.errors[:base] << "Video is already in queue."
      vid
    end
  end

end
