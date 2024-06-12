require 'rails_helper'

RSpec.describe GeoapifyService do
  it 'exists' do
    service = GeoapifyService.new

    expect(service).to be_a (GeoapifyService)
  end

  it '#get_coordinates_from_query(searched_for_country)' do
    service = GeoapifyService.new

    json_response = File.read('spec/fixtures/geo_coordinates.json')
    stub_request(:get, "https://api.geoapify.com/v1/geocode/search?text=France&type=country&format=json&apiKey=#{Rails.application.credentials.geoapify[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/geo_sites.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.geoapify[:key]}&categories=tourism&bias=proximity:1.8883335,46.603354").to_return(status: 200, body: json_response)

    result = service.get_coordinates_from_query('France')

    expect(result).to be_a (Hash)
    expect(result[:results]).to be_a (Array)
    expect(result[:results][0]).to be_a (Hash)
    expect(result[:results][0]).to have_key (:lat)
    expect(result[:results][0]).to have_key (:lon)
  end

  it '#get_tourist_sites_from_coordinates(latitude, longitude)' do
    service = GeoapifyService.new

    json_response = File.read('spec/fixtures/geo_coordinates.json')
    stub_request(:get, "https://api.geoapify.com/v1/geocode/search?text=France&type=country&format=json&apiKey=#{Rails.application.credentials.geoapify[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/geo_sites.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.geoapify[:key]}&categories=tourism&bias=proximity:1.8883335,46.603354").to_return(status: 200, body: json_response)

    result = service.get_tourist_sites_from_coordinates('46.603354', '1.8883335')

    expect(result).to be_a (Hash)
    expect(result[:features]).to be_a (Array)
    expect(result[:features][0]).to have_key (:properties)
    expect(result[:features][0][:properties]).to be_a (Hash)
    expect(result[:features][0][:properties]).to have_key (:name)
    expect(result[:features][0][:properties]).to have_key (:formatted)
    expect(result[:features][0][:properties]).to have_key (:place_id)
    expect(result[:features][0][:properties][:name]).to eq ('Calvaire')
    expect(result[:features][0][:properties][:formatted]).to eq ('Calvaire, Place des Combattants en AFN, 36230 Sarzay, France')
    expect(result[:features][0][:properties][:place_id]).to eq ('51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265')
  end

  it '#get_url(url)' do
    service = GeoapifyService.new

    json_response = File.read('spec/fixtures/geo_coordinates.json')
    stub_request(:get, "https://api.geoapify.com/v1/geocode/search?text=France&type=country&format=json&apiKey=#{Rails.application.credentials.geoapify[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/geo_sites.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.geoapify[:key]}&categories=tourism&bias=proximity:1.8883335,46.603354").to_return(status: 200, body: json_response)

    result = service.get_url('/v2/places?&categories=tourism&bias=proximity:1.8883335,46.603354')

    expect(result).to be_a (Hash)
    expect(result[:features]).to be_a (Array)
    expect(result[:features][0]).to have_key (:properties)
    expect(result[:features][0][:properties]).to be_a (Hash)
    expect(result[:features][0][:properties]).to have_key (:name)
    expect(result[:features][0][:properties]).to have_key (:formatted)
    expect(result[:features][0][:properties]).to have_key (:place_id)
    expect(result[:features][0][:properties][:name]).to eq ('Calvaire')
    expect(result[:features][0][:properties][:formatted]).to eq ('Calvaire, Place des Combattants en AFN, 36230 Sarzay, France')
    expect(result[:features][0][:properties][:place_id]).to eq ('51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265')
  end

  it '#api_connection' do
    service = GeoapifyService.new

    result = service.api_connection

    expect(result).to be_a (Faraday::Connection)
    expect(result.params[:apiKey]).to eq (Rails.application.credentials.geoapify[:key])
  end
end