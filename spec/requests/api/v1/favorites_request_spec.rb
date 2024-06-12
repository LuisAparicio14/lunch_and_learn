require 'rails_helper'

RSpec.describe 'Favorites Requests' do
  it 'adding a favorite - returns the correct response if the api key is valid' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )

    expect(user.favorites.count).to eq (0)

    post '/api/v1/favorites', params:
    {
      "api_key": "1234567890asdfghjkl",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }

    expect(user.favorites.count).to eq (1)

    expect(response).to be_successful
    expect(response.status).to eq (201)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:success)
    expect(parsed_json[:success]).to be_a (String)
    expect(parsed_json[:success]).to eq ('Favorite added successfully')
  end

  it 'adding a favorite - returns the correct response if the api key is not valid' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )

    post '/api/v1/favorites', params:
    {
      "api_key": "1111111111111",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }

    expect(response).to_not be_successful
    expect(response.status).to eq (400)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:error)
    expect(parsed_json[:error]).to be_a (String)
    expect(parsed_json[:error]).to eq ('No user found with that key')
  end

  it 'getting favorites - returns the correct response if the api key is valid and the user has favorite recipes' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )
    fave1 = user.favorites.create!(
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/.....",
      recipe_title: "Recipe 1 - Crab Fried Rice"
    )
    fave2 = user.favorites.create!(
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/.....",
      recipe_title: "Recipe 2 - Wonton Soup"
    )

    get '/api/v1/favorites?api_key=1234567890asdfghjkl'

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data].count).to eq (2)
    expect(parsed_json[:data][0].keys.count).to eq (3)
    expect(parsed_json[:data][0]).to have_key (:id)
    expect(parsed_json[:data][0]).to have_key (:type)
    expect(parsed_json[:data][0]).to have_key (:attributes)
    expect(parsed_json[:data][0][:id]).to be_a (String)
    expect(parsed_json[:data][0][:type]).to be_a (String)
    expect(parsed_json[:data][0][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][0][:attributes].keys.count).to eq (4)
    expect(parsed_json[:data][0][:attributes]).to have_key (:recipe_title)
    expect(parsed_json[:data][0][:attributes]).to have_key (:recipe_link)
    expect(parsed_json[:data][0][:attributes]).to have_key (:country)
    expect(parsed_json[:data][0][:attributes]).to have_key (:created_at)
    expect(parsed_json[:data][0][:attributes][:recipe_title]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:recipe_link]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:country]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:created_at]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:recipe_title]).to eq ('Recipe 1 - Crab Fried Rice')
    expect(parsed_json[:data][0][:attributes][:recipe_link]).to eq ('https://www.tastingtable.com/.....')
    expect(parsed_json[:data][0][:attributes][:country]).to eq ('thailand')
  end

  it 'getting favorites - returns the correct response if the api key is valid and the user does not hav any favorite recipes' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )

    get '/api/v1/favorites?api_key=1234567890asdfghjkl'

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data].empty?).to eq (true)
    expect(parsed_json[:data].count).to eq (0)
  end

  it 'getting favorites - returns the correct response if the api key is not valid' do
    user = User.create(
      name: 'Luis',
      email: 'luisaparicio2004@gmail.com',
      api_key: 'a1b2c3d4e5f6',
      password: 'hello123',
      password_confirmation: 'hello123'
    )
    user.favorites.create!(
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/.....",
      recipe_title: "Recipe 1 - Crab Fried Rice"
    )
    user.favorites.create!(
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/.....",
      recipe_title: "Recipe 2 - Wonton Soup"
    )

    get '/api/v1/favorites?api_key=1111111111111111111111'

    expect(response).to_not be_successful
    expect(response.status).to eq (400)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:error)
    expect(parsed_json[:error]).to be_a (String)
    expect(parsed_json[:error]).to eq ('No user found with that key')
  end
end