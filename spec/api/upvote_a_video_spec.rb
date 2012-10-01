require 'spec_helper'

feature 'user can upvote a video' do

  let(:video) do
    SubmittedVideo.create({
      :youtube_video_id => 'AyzOUbkUf3M',
      :user_id => '44'
    })
  end

  scenario 'video is in queue' do
    post("/videos/#{video.id}/votes.json", {
      :user_id => '22'
    })

    response.status.should == 201 # created

    result = ActiveSupport::JSON.decode(response.body)

    result.should have_key 'id'

    video.reload
    video.upvotes.should == 1
    video.upvotes.should == video.votes.count
  end

  scenario 'user can only upvote a video once' do
    post("/videos/#{video.id}/votes.json", {
      :user_id => '22'
    })

    response.status.should == 201 # created

    post("/videos/#{video.id}/votes.json", {
      :user_id => '22'
    })

    response.status.should == 422 # unprocessable...

    video.reload
    video.upvotes.should == 1
    video.upvotes.should == video.votes.count
  end

  scenario 'upvotes get counted in the video' do
    post("/videos/#{video.id}/votes.json", {
      :user_id => '22'
    })

    post("/videos/#{video.id}/votes.json", {
      :user_id => '2'
    })

    response.status.should == 201

    video.reload
    video.upvotes.should == 2
  end

  scenario 'removing votes also works' do
    post("/videos/#{video.id}/votes.json", {
      :user_id => '22'
    })

    response.status.should == 201
    result = ActiveSupport::JSON.decode(response.body)

    video.reload
    video.upvotes.should == 1

    vote_id = result['id']

    delete("/videos/#{video.id}/votes/#{vote_id}.json", {
      :user_id => '22'
    })

    response.status.should == 204 # no content

    video.reload
    video.upvotes.should == 0

    post("/videos/#{video.id}/votes.json", {
      :user_id => '22'
    })

    response.status.should == 201
    video.reload
    video.upvotes.should == 1
  end
end


