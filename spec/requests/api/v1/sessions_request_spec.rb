require 'rails_helper'

RSpec.describe 'Sessions Requests' do
  it 'logging in a user - returns the correct response if the credentials are valid' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )    

    post '/api/v1/sessions', params:
    {
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf"
    }

    expect(response).to be_successful
    expect(response.status).to eq (201)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Hash)
    expect(parsed_json[:data].keys.count).to eq (3)
    expect(parsed_json[:data]).to have_key (:type)
    expect(parsed_json[:data]).to have_key (:id)
    expect(parsed_json[:data]).to have_key (:attributes)
    expect(parsed_json[:data][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][:attributes].keys.count).to eq (3)
    expect(parsed_json[:data][:attributes]).to have_key (:name)
    expect(parsed_json[:data][:attributes]).to have_key (:email)
    expect(parsed_json[:data][:attributes]).to have_key (:api_key)
    expect(parsed_json[:data][:attributes][:name]).to be_a (String)
    expect(parsed_json[:data][:attributes][:email]).to be_a (String)
    expect(parsed_json[:data][:attributes][:api_key]).to be_a (String)
    expect(parsed_json[:data][:attributes][:name]).to eq ('Grant')
    expect(parsed_json[:data][:attributes][:email]).to eq ('goodboy@ruffruff.com')
    expect(parsed_json[:data][:attributes][:api_key]).to eq ('1234567890asdfghjkl')
  end

  it 'logging in a user - returns the correct response if the credentials are not valid' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )
    

    post '/api/v1/sessions', params:
    {
      "email": "goodboy@ruffruff.com",
      "password": "treas4liferrr"
    }

    expect(response).to_not be_successful
    expect(response.status).to eq (400)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:error)
    expect(parsed_json[:error]).to be_a (String)
    expect(parsed_json[:error]).to eq ('Bad credentials')
  end

  it 'logging in a user - returns the correct response if the user does not exist' do
    post '/api/v1/sessions', params:
    {
      "email": "goodboy@ruffruff.com",
      "password": "treas4liferrr"
    }

    expect(response).to_not be_successful
    expect(response.status).to eq (400)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:error)
    expect(parsed_json[:error]).to be_a (String)
    expect(parsed_json[:error]).to eq ('User does not exist')
  end
end