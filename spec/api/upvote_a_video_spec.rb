require 'spec_helper'

feature 'user can upvote a video' do

  let(:video) do
    SubmittedVideo.create({
      :youtube_video_id => 'AyzOUbkUf3M',
      :user_id => '44'
    })
  end

  scenario 'video is in queue' do
    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    response.status.should == 201 # created

    video.reload
    video.upvotes.should == 1
    video.upvotes.should == video.votes.count
  end

  scenario 'user can only upvote a video once' do
    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    response.status.should == 201 # created

    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    response.status.should == 422 # unprocessable...

    video.reload
    video.upvotes.should == 1
    video.upvotes.should == video.votes.count
  end

  scenario 'upvotes get counted in the video' do
    post("/videos/#{video.id}/vote.json", {
      :user_id => '22'
    })

    post("/videos/#{video.id}/vote.json", {
      :user_id => '2'
    })

    response.status.should == 201

    video.reload
    video.upvotes.should == 2
  end
end
