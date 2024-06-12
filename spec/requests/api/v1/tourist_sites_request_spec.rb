require 'rails_helper'

RSpec.describe 'Tourist Sites Requests' do
  it 'returns an array of the top 10 tourist site objects' do
    json_response = File.read('spec/fixtures/geo_coordinates.json')
    stub_request(:get, "https://api.geoapify.com/v1/geocode/search?text=France&type=country&format=json&apiKey=#{Rails.application.credentials.geoapify[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/geo_sites.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.geoapify[:key]}&categories=tourism&bias=proximity:1.8883335,46.603354").to_return(status: 200, body: json_response)

    get '/api/v1/tourist_sites?country=France'

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data][0]).to be_a (Hash)
    expect(parsed_json[:data][0].keys.count).to eq (3)
    expect(parsed_json[:data][0]).to have_key (:id)
    expect(parsed_json[:data][0]).to have_key (:type)
    expect(parsed_json[:data][0]).to have_key (:attributes)
    expect(parsed_json[:data][0][:id]).to eq (nil)
    expect(parsed_json[:data][0][:type]).to eq ('tourist_site')
    expect(parsed_json[:data][0][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][0][:attributes].keys.count).to eq (3)
    expect(parsed_json[:data][0][:attributes]).to have_key (:name)
    expect(parsed_json[:data][0][:attributes]).to have_key (:address)
    expect(parsed_json[:data][0][:attributes]).to have_key (:place_id)
    expect(parsed_json[:data][0][:attributes][:name]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:address]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:place_id]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:name]).to eq ('Calvaire')
    expect(parsed_json[:data][0][:attributes][:address]).to eq ('Calvaire, Place des Combattants en AFN, 36230 Sarzay, France')
    expect(parsed_json[:data][0][:attributes][:place_id]).to eq ('51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265')
  end
end