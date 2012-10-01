class VotesController < ApplicationController
  respond_to :html, :json

  def create
    @video = SubmittedVideo.find(params[:video_id])
    @vote = @video.upvoted_by_user(params[:user_id]) if @video

    if @vote and @vote.errors.empty?
      respond_with @vote, :location => video_url(@video)
    else
      respond_with @vote, :location => nil, :status => :unprocessable_entity
    end
  end

  def destroy
    @video = SubmittedVideo.find(params[:video_id])
    successful = @video.unvote_by_user(params[:user_id]) if @video

    if successful
      respond_with nil, :location => nil
    else
      respond_with nil, :location => nil, :status => :unprocessable_entity
    end
  end

end
