require 'rails_helper'

RSpec.describe LearningResource do
  it 'exists and can initialize' do
    learning_resource = LearningResource.new({
      country: 'Laos',
      video: {
        title: 'Title of an awesome Laos video',
        youtube_video_id: '1234abcd'
      },
      images: [{
        alt_tag: 'A beautiful view of mountains in Laos',
        url: 'https://images.supercoolurl.com/123'
      }]
    })

    expect(learning_resource).to be_a LearningResource
    expect(learning_resource.country).to eq ('Laos')
    expect(learning_resource.video).to be_a (Hash)
    expect(learning_resource.video[:title]).to eq ('Title of an awesome Laos video')
    expect(learning_resource.video[:youtube_video_id]).to eq ('1234abcd')
    expect(learning_resource.images).to be_a (Array)
    expect(learning_resource.images[0]).to be_a (Hash)
    expect(learning_resource.images[0][:alt_tag]).to eq ('A beautiful view of mountains in Laos')
    expect(learning_resource.images[0][:url]).to eq ('https://images.supercoolurl.com/123')
  end
end