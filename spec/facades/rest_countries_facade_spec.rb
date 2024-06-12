require 'rails_helper'

RSpec.describe RestCountriesFacade do
  it 'exists' do
    facade = RestCountriesFacade.new

    expect(facade).to be_a (RestCountriesFacade)
  end

  it '#get_list_of_all_countries' do
    facade = RestCountriesFacade.new

    json_response = File.read('spec/fixtures/all_countries.json')
    stub_request(:get, "https://restcountries.com/v3.1/all").to_return(status: 200, body: json_response)

    result = facade.get_list_of_all_countries

    expect(result).to be_a (Array)
    expect(result[0]).to be_a (String)
    expect(result[0]).to eq ('Angola')
    expect(result[1]).to be_a (String)
    expect(result[1]).to eq ('Kiribati')
    expect(result[2]).to be_a (String)
    expect(result[2]).to eq ('Guernsey')
    expect(result[3]).to be_a (String)
    expect(result[3]).to eq ('Guadeloupe')
    expect(result.length).to eq (250)
  end
end