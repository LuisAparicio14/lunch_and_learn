require 'rails_helper'

RSpec.describe GoogleService do
  it 'exists' do
    service = GoogleService.new

    expect(service).to be_a (GoogleService)
  end

  it '#get_video_from_query(searched_for_country)' do
    service = GoogleService.new

    json_response = File.read('spec/fixtures/youtube_videos.json')
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=laos&key=#{Rails.application.credentials.google[:key]}").to_return(status: 200, body: json_response)

    result = service.get_video_from_query('laos')

    expect(result).to be_a (Hash)
    expect(result[:items]).to be_a (Array)
    expect(result[:items][0][:id][:videoId]).to eq ('uw8hjVqxMXw')
    expect(result[:items][0][:snippet][:title]).to eq ('A Super Quick History of Laos')
  end

  it '#get_url(url)' do
    service = GoogleService.new

    json_response = File.read('spec/fixtures/youtube_videos.json')
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=laos&key=#{Rails.application.credentials.google[:key]}").to_return(status: 200, body: json_response)

    result = service.get_url('/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=laos')

    expect(result).to be_a (Hash)
    expect(result[:items]).to be_a (Array)
    expect(result[:items][0][:id][:videoId]).to eq ('uw8hjVqxMXw')
    expect(result[:items][0][:snippet][:title]).to eq ('A Super Quick History of Laos')
  end

  it '#api_connection' do
    service = GoogleService.new

    result = service.api_connection

    expect(result).to be_a (Faraday::Connection)
    expect(result.params[:part]).to eq ('snippet')
    expect(result.params[:channelId]).to eq ('UCluQ5yInbeAkkeCndNnUhpw')
    expect(result.params[:key]).to eq (Rails.application.credentials.google[:key])
  end
end