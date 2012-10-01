class VideosController < ApplicationController

  respond_to :html, :json

  def create
    @video = SubmittedVideo.add_to_queue(:youtube_video_id => params[:youtube_video_id], :user_id => params[:user_id])
    if @video.errors.empty?
      respond_with @video, :location => video_url(@video)
    else
      respond_with @video.errors, :status => :conflict, :location => nil
    end
  end

  def vote
    @video = SubmittedVideo.find(params[:id])
    @vote = @video.upvoted_by_user(params[:user_id]) if @video

    if @vote.errors.empty?
      respond_with @vote, :location => video_url(@video)
    else
      respond_with @vote, :location => nil
    end
  end

end
