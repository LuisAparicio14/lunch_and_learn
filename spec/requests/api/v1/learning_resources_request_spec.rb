require 'rails_helper'

RSpec.describe 'Learning Resources Requests' do
  it 'returns a video hash and photos array when a country is entered' do
    json_response = File.read('spec/fixtures/youtube_videos.json')
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=laos&key=#{Rails.application.credentials.google[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/unsplash_photos.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?query=laos&client_id=#{Rails.application.credentials.unsplash[:key]}").to_return(status: 200, body: json_response)

    get '/api/v1/learning_resources?country=laos'

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Hash)
    expect(parsed_json[:data].keys.count).to eq (3)
    expect(parsed_json[:data]).to have_key (:id)
    expect(parsed_json[:data]).to have_key (:type)
    expect(parsed_json[:data]).to have_key (:attributes)
    expect(parsed_json[:data][:id]).to eq (nil)
    expect(parsed_json[:data][:type]).to eq ('learning_resource')
    expect(parsed_json[:data][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][:attributes].keys.count).to eq (3)
    expect(parsed_json[:data][:attributes]).to have_key (:country)
    expect(parsed_json[:data][:attributes]).to have_key (:video)
    expect(parsed_json[:data][:attributes]).to have_key (:images)
    expect(parsed_json[:data][:attributes][:country]).to eq ('laos')
    expect(parsed_json[:data][:attributes][:video]).to be_a (Hash)
    expect(parsed_json[:data][:attributes][:video].keys.count).to eq (2)
    expect(parsed_json[:data][:attributes][:video]).to have_key (:title)
    expect(parsed_json[:data][:attributes][:video]).to have_key (:youtube_video_id)
    expect(parsed_json[:data][:attributes][:video][:title]).to eq ('A Super Quick History of Laos')
    expect(parsed_json[:data][:attributes][:video][:youtube_video_id]).to eq ('uw8hjVqxMXw')
    expect(parsed_json[:data][:attributes][:images]).to be_a (Array)
    expect(parsed_json[:data][:attributes][:images][0]).to be_a (Hash)
    expect(parsed_json[:data][:attributes][:images][0].keys.count).to eq (2)
    expect(parsed_json[:data][:attributes][:images][0]).to have_key (:alt_tag)
    expect(parsed_json[:data][:attributes][:images][0]).to have_key (:url)
    expect(parsed_json[:data][:attributes][:images][0][:alt_tag]).to be_a (String)
    expect(parsed_json[:data][:attributes][:images][0][:alt_tag]).to eq ('time lapse photography of flying hot air balloon')
    expect(parsed_json[:data][:attributes][:images][0][:url]).to be_a (String)
    expect(parsed_json[:data][:attributes][:images][0][:url]).to eq ('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=M3w2MjA1ODN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcxNzg5MTgyN3ww&ixlib=rb-4.0.3')
    expect(parsed_json[:data][:attributes][:images].count).to eq (10)
  end

  it 'returns an empty video hash and empty photos array when a country is entered with no learning resources' do
    json_response = File.read('spec/fixtures/youtube_videos_tokelau.json')
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=tokelau&key=#{Rails.application.credentials.google[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/tokelau_photos.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?query=tokelau&client_id=#{Rails.application.credentials.unsplash[:key]}").to_return(status: 200, body: json_response)

    get '/api/v1/learning_resources?country=tokelau'

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Hash)
    expect(parsed_json[:data].keys.count).to eq (3)
    expect(parsed_json[:data]).to have_key (:id)
    expect(parsed_json[:data]).to have_key (:type)
    expect(parsed_json[:data]).to have_key (:attributes)
    expect(parsed_json[:data][:id]).to eq (nil)
    expect(parsed_json[:data][:type]).to eq ('learning_resource')
    expect(parsed_json[:data][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][:attributes].keys.count).to eq (3)
    expect(parsed_json[:data][:attributes][:country]).to be_a (String)
    expect(parsed_json[:data][:attributes][:video]).to be_a (Hash)
    expect(parsed_json[:data][:attributes][:images]).to be_a (Array)
    expect(parsed_json[:data][:attributes][:country]).to eq ('tokelau')
    expect(parsed_json[:data][:attributes][:video]).to eq ({})
    expect(parsed_json[:data][:attributes][:images]).to eq ([])
  end
end