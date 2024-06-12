require 'rails_helper'

RSpec.describe RestCountriesService do
  it 'exists' do
    service = RestCountriesService.new

    expect(service).to be_a (RestCountriesService)
  end

  it '#all_countries' do
    service = RestCountriesService.new

    json_response = File.read('spec/fixtures/all_countries.json')
    stub_request(:get, "https://restcountries.com/v3.1/all").to_return(status: 200, body: json_response)

    result = service.all_countries

    expect(result).to be_a (Array)
    expect(result[0]).to be_a (Hash)
    expect(result[0][:name][:common]).to eq ('Angola')
    expect(result[1][:name][:common]).to eq ('Kiribati')
    expect(result[2][:name][:common]).to eq ('Guernsey')
    expect(result[3][:name][:common]).to eq ('Guadeloupe')
  end

  it '#get_url(url)' do
    service = RestCountriesService.new

    json_response = File.read('spec/fixtures/all_countries.json')
    stub_request(:get, "https://restcountries.com/v3.1/all").to_return(status: 200, body: json_response)

    result = service.get_url('/v3.1/all')

    expect(service.get_url('/v3.1/all')).to be_a (Array)
    expect(service.get_url('/v3.1/all')[0]).to be_a (Hash)
    expect(service.get_url('/v3.1/all')[0][:name][:common]).to eq ('Angola')
    expect(service.get_url('/v3.1/all')[1][:name][:common]).to eq ('Kiribati')
    expect(service.get_url('/v3.1/all')[2][:name][:common]).to eq ('Guernsey')
    expect(service.get_url('/v3.1/all')[3][:name][:common]).to eq ('Guadeloupe')
  end

  it '#api_connection' do
    service = RestCountriesService.new

    result = service.api_connection

    expect(result).to be_a (Faraday::Connection)
  end
end