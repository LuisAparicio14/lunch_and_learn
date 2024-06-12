require 'rails_helper'

RSpec.describe GeoapifyFacade do
  it 'exists' do
    facade = GeoapifyFacade.new

    expect(facade).to be_a (GeoapifyFacade)
  end

  it '#get_coordinates(searched_for_country)' do
    facade = GeoapifyFacade.new

    json_response = File.read('spec/fixtures/geo_coordinates.json')
    stub_request(:get, "https://api.geoapify.com/v1/geocode/search?text=France&type=country&format=json&apiKey=#{Rails.application.credentials.geoapify[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/geo_sites.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.geoapify[:key]}&categories=tourism&bias=proximity:1.8883335,46.603354").to_return(status: 200, body: json_response)

    result = facade.get_coordinates('France')

    expect(result).to be_a (Array)
    expect(result[0]).to be_a (TouristSite)
    expect(result[0]).to have_attributes(
      :name => 'Calvaire',
      :address => 'Calvaire, Place des Combattants en AFN, 36230 Sarzay, France',
      :place_id => '51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265'
    )
    expect(result.length).to eq (10)
  end

  it '#create_poros_for_tourist_sites(all_tourist_sites)' do
    facade = GeoapifyFacade.new

    json_response = File.read('spec/fixtures/geo_coordinates.json')
    stub_request(:get, "https://api.geoapify.com/v1/geocode/search?text=France&type=country&format=json&apiKey=#{Rails.application.credentials.geoapify[:key]}").to_return(status: 200, body: json_response)

    json_response = File.read('spec/fixtures/geo_sites.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.geoapify[:key]}&categories=tourism&bias=proximity:1.8883335,46.603354").to_return(status: 200, body: json_response)

    all_tourist_sites = [{
      properties: {
        name: "Calvaire",
        formatted: "Calvaire, Place des Combattants en AFN, 36230 Sarzay, France",
        place_id: "51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265"
      }
    }]

    result = facade.create_poros_for_tourist_sites(all_tourist_sites)

    expect(result).to be_a (Array)
    expect(result[0]).to be_a (TouristSite)
    expect(result[0]).to have_attributes(
      :name => 'Calvaire',
      :address => 'Calvaire, Place des Combattants en AFN, 36230 Sarzay, France',
      :place_id => '51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265'
    )
    expect(result.length).to eq (1)
  end
end