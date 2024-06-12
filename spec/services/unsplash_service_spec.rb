require 'rails_helper'

RSpec.describe UnsplashService do
  it 'exists' do
    service = UnsplashService.new

    expect(service).to be_a (UnsplashService)
  end

  it '#get_images_from_query(searched_for_country)' do
    service = UnsplashService.new

    json_response = File.read('spec/fixtures/unsplash_photos.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?query=laos&client_id=#{Rails.application.credentials.unsplash[:key]}").to_return(status: 200, body: json_response)

    result = service.get_images_from_query('laos')

    expect(result).to be_a (Hash)
    expect(result[:results]).to be_a (Array)
    expect(result[:results][0][:id]).to eq ('yJ2SHIpNb9M')
    expect(result[:results][0][:urls][:raw]).to eq ('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=M3w2MjA1ODN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcxNzg5MTgyN3ww&ixlib=rb-4.0.3')
  end

  it '#get_url(url)' do
    service = UnsplashService.new

    json_response = File.read('spec/fixtures/unsplash_photos.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?query=laos&client_id=#{Rails.application.credentials.unsplash[:key]}").to_return(status: 200, body: json_response)

    result = service.get_url('/search/photos?query=laos')

    expect(result).to be_a (Hash)
    expect(result[:results]).to be_a (Array)
    expect(result[:results][0][:id]).to eq ('yJ2SHIpNb9M')
    expect(result[:results][0][:urls][:raw]).to eq ('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=M3w2MjA1ODN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcxNzg5MTgyN3ww&ixlib=rb-4.0.3')
  end

  it '#api_connection' do
    service = UnsplashService.new

    result = service.api_connection

    expect(result).to be_a (Faraday::Connection)
    expect(result.params[:client_id]).to eq (Rails.application.credentials.unsplash[:key])
  end
end