require 'spec-helper'

feature 'user can submit a video' do

  scenario 'no videos exist' do
    post('/videos.json', {
      user_id: '1234',
      yt_id: 'mxPXPv3oNY4'
    })

    response.status.should == 200
  end

  scenario 'video is already in queue' do
    existing = SubmittedVideo.create({
      yt_id: 'Y8-CZaHFTdQ',
      user_id: '1234'
    })

    post('/videos.json', {
      user_id: '3456',
      yt_id: 'Y8-CZaHFTdQ'
    })

    response.status.should == 409 # conflict
  end

  scenario 'video was in queue, but already fininshed playing' do
    # if the video finished playing, it should be re-submittable
    existing = SubmittedVideo.create({
      yt_id: 'Zg6iMDfOl9E',
      user_id: '22'
    })
    existing.update_attribute(:finished_at, DateTime.now - 2.minutes)
    existing.save

    post('/videos.json', {
      user_id: '33',
      yt_id: 'Zg6iMDfOl9E'
    })

    response.status.should == 200
  end
end
