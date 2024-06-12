require 'rails_helper'

RSpec.describe GoogleFacade do
  it 'exists' do
    facade = GoogleFacade.new

    expect(facade).to be_a (GoogleFacade)
  end

  it '#get_video(searched_for_country)' do
    facade = GoogleFacade.new

    json_response = File.read('spec/fixtures/youtube_videos.json')
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=laos&key=#{Rails.application.credentials.google[:key]}").to_return(status: 200, body: json_response)

    result = facade.get_video('laos')

    expect(result).to be_a LearningResource
    expect(result.country).to eq ('laos')
    expect(result.video).to be_a (Hash)
    expect(result.video[:title]).to eq ('A Super Quick History of Laos')
    expect(result.video[:youtube_video_id]).to eq ('uw8hjVqxMXw')
    expect(result.images).to be_a (Array)
  end
end