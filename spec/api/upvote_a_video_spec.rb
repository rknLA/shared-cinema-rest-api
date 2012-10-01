require 'spec_helper'

feature 'user can upvote a video' do

  scenario 'video is in queue' do
    video = SubmittedVideo.create({
      :youtube_video_id => 'AyzOUbkUf3M',
      :user_id => '44'
    })

    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    response.status.should == 201 # created
  end

  scenario 'user can only upvote a video once' do
    video = SubmittedVideo.create({
      :youtube_video_id => 'AyzOUbkUf3M',
      :user_id => '44'
    })

    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    response.status.should == 201 # created

    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    response.status.should == 422 # unprocessable...
  end
end
