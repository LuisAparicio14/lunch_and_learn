require 'rails_helper'

RSpec.describe 'Recipes Requests' do
  it 'returns a list of recipes with a country entered 1' do
    json_response = File.read('spec/fixtures/thailand_recipes.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=thailand&app_id=08e8c11c&app_key=#{Rails.application.credentials.edamam[:key]}").to_return(status: 200, body: json_response)

    get '/api/v1/recipes?country=thailand'

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
    expect(parsed_json[:data][0][:type]).to be_a (String)
    expect(parsed_json[:data][0][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][0][:id]).to eq (nil)
    expect(parsed_json[:data][0][:type]).to eq ('recipe')
    expect(parsed_json[:data][0][:attributes].keys.count).to eq (4)
    expect(parsed_json[:data][0][:attributes]).to have_key (:title)
    expect(parsed_json[:data][0][:attributes]).to have_key (:url)
    expect(parsed_json[:data][0][:attributes]).to have_key (:country)
    expect(parsed_json[:data][0][:attributes]).to have_key (:image)
    expect(parsed_json[:data][0][:attributes][:title]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:url]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:country]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:image]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:title]).to eq ('Steamed Thailand Turkey Burger')
    expect(parsed_json[:data][0][:attributes][:url]).to eq ('https://food52.com/recipes/21104-steamed-thailand-turkey-burger')
    expect(parsed_json[:data][0][:attributes][:country]).to eq ('thailand')
    expect(parsed_json[:data][0][:attributes][:image]).to eq ('https://edamam-product-images.s3.amazonaws.com/web-img/d7a/d7aadde1ff6875e8d46f46c692691d73.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEH4aCXVzLWVhc3QtMSJHMEUCIFTVBHngbcaSrnlUA5aTGI%2FgOfQ90CfHNOPBjl6ZMKGRAiEA4mYxrk59ijZcAbyRJ4oiRsmEfQsYU9XEXp27LliJJnsquQUIFxAAGgwxODcwMTcxNTA5ODYiDIYHIARUNghRCW3kqiqWBS3hqgY74to%2FIHu0dNWe3MmG50R%2FQ6halJb1KnrLFmhUr2B9XGZoF4mw%2FDwEaWzqAr9HQ1wXOJU2g54PJZKA%2BNlErzJ1OFk0%2BJZLLJeerlkHMpvxWNbe9rIH4uckfVxD2Rak%2BmQBgIBH5mL96uBj5l%2BQsAOt32A20G3lv%2Bbj1VoB2pZS6qOAAWS6EITzz2x2Z9uQ15bRCM4JlRfQHHl%2BaC64%2BIXyPvN7B3rD1Lx6OgOW3p0v0ap3DSBv%2B8QSpG9CfAU%2FxAm8wPhwUVhgmpwT27JiPteYu0DzPyjVrNPytawhCh7LCiyk61YS8KqBiKiZkRY6lcwrw1MEg70V5ZaA3l6zD7GhoEgK06M7o19ubwg8Fm56rSJfQXRkVgeXnWSy7SMXsjnw3%2B6plpdjCDHAgww3N0qQiSgMbhgCrDR%2FVqPzIOM7tj%2BLNOucUjg9lteJITQwj%2BDiAffLqAVAY125RB4ufwDmDvKGvgaK4MkPpMxL64WF0k0o6ctdD1IG1F%2B0WhqLdrC9stfJwpXsycSOg0tw3EOQr%2FzVz5bt%2FW0xgus%2FlmHx%2BnHLtrTPGJIwdFQ%2B2BXhK26qBwxItgw4WPqWUv40URdzHg6RfvfibktveI8t5ubgnLVZFegZJ3Sc5Q4ZyJCZq3GjgjI4cbRFbFn%2FKgKCARiyOh9gI3AXqwtaAfitMj1gkW5NlScWw8Fljm1Q7FvaeufcBlAQtHH3l%2BGol%2FTmWyRPHw0B8pY8FtbT863Ojv%2BLNbPdU%2BAHlJF6K6R9ohvqyqx6Gr8ahSv7lp%2BUL80ZofC%2FGl3lEPf93x8FQmf1JLWRffsqbkikhChhdQ6CV2mIZ3STqfMP0uTbqPD%2FQ8E7ZrJRBxR1AczfcVXShiYxkHcdP7LoMM24kbMGOrEBe0au2JH50qGaHIo80a%2BXzTDgAdLA6pqQe03ESINcTqeUVEHaTqU73nzb7%2FGw3aAcmsZ26VSpRiwXt%2BR4SkCx0Gn2mdQh5EJwe8hilaoq3yEeBhfaD%2BMHmnuR%2Fxvi3a5bvdd7pHhe0nahZT5XHl2Ogiy4vXN3TWeIyvJ45JDRhDLiWAriE7mMLttSSUHN%2FSitKRphDtaKD2RtpPXERU%2FbQjbXpgIEoUld96129xqsqT1Q&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240608T140649Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIIOKD7VB%2F20240608%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=7416cd482ebc431e4f8d4ca56803ee9dbcefd0806cf1e51290a638441873e428')
  end

  it 'returns a list of recipes with a country entered 2' do
    json_response = File.read('spec/fixtures/portugal_recipes.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=portugal&app_id=08e8c11c&app_key=#{Rails.application.credentials.edamam[:key]}").to_return(status: 200, body: json_response)

    get '/api/v1/recipes?country=portugal'

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
    expect(parsed_json[:data][0][:type]).to be_a (String)
    expect(parsed_json[:data][0][:attributes]).to be_a (Hash)
    expect(parsed_json[:data][0][:id]).to eq (nil)
    expect(parsed_json[:data][0][:type]).to eq ('recipe')
    expect(parsed_json[:data][0][:attributes].keys.count).to eq (4)
    expect(parsed_json[:data][0][:attributes]).to have_key (:title)
    expect(parsed_json[:data][0][:attributes]).to have_key (:url)
    expect(parsed_json[:data][0][:attributes]).to have_key (:country)
    expect(parsed_json[:data][0][:attributes]).to have_key (:image)
    expect(parsed_json[:data][0][:attributes][:title]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:url]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:country]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:image]).to be_a (String)
    expect(parsed_json[:data][0][:attributes][:title]).to eq ('Portuguese Seafood Stew that Reminds Us of Portugal')
    expect(parsed_json[:data][0][:attributes][:url]).to eq ('https://food52.com/recipes/21441-seafood-stew-that-reminds-us-of-portugal')
    expect(parsed_json[:data][0][:attributes][:country]).to eq ('portugal')
    expect(parsed_json[:data][0][:attributes][:image]).to eq ('https://edamam-product-images.s3.amazonaws.com/web-img/30b/30b46472be9717db4d963b0e7f34786c.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEIT%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIEJ%2FK%2Bykdp9xrnOKFYwv0Syn0jwKzE%2BsybLhyYCscEyzAiEA%2F3h1nAGIpx6wxSTFR9cdC43A1nPfZKpl4XjAtFvyfw0quAUIHRAAGgwxODcwMTcxNTA5ODYiDL5ypKYw82oDMcMaDyqVBeuGqxDk2pgGRZrp%2FsluIeRA5tRUDLtL8gc7KZ%2BAA8FCE3oRvPlbrF84OkwJ%2Fq9MT9XzP0iQdEOJyh3afyyTF6JQ7M4Zx5HtCanx5tpOt7SM4gaLvSvMCN3TNYfxqN71uchP3MXCW2aUaa5Vty8qAZCwCncR0ytxOy7ztunhEAmYWTif%2B%2BUkVB7ypHsryZQjaIv0Qn3SlYUXh8UNEqiV0eR2v3%2F%2F22vaIWyxw1M44o6H4haHWRcW%2BOZaVV9K7ipIUMRU6es7mUzlSUSHpGmd42Ugq%2BLKAmuqVunTdXgDUuzGyrqy9bnLABKkOY9dB%2FBXgdoqsuNLHb1dOW3tw7P%2FgYJf6GBPMx7t0PSBuMgxcOSCqJnqu0F2KIlDzhB%2BwT18uogqXQQyDXr2njuB4caFBJzMp%2BOVB2lQv%2FJUmckuIugtjUoEYL9gqcrbXXTnChrmYROsECXWT73rj%2BEJE%2BkUU6ghG6DxXd9XmkX%2BhDp170K84bAl1jbuEYRq%2B2BUHccE%2FYvjGX3jkncnhJs1RNSG%2FF6UOagden3Y6ZER4cQOgAC7%2Btcgr1Q9nNtHIxV4DFD5E5CXsh9Zrhrvo0Ujj%2FErG8jFECTFAUXVu9iroQGQxibEMCB1PyDJlLaZJ%2FwQmTfG11MUxD37rmYGe8yz5mL%2FJSIzYpNnikrLjkY3tY7C4lXlcWh27UmdwOdaBE2zeTcAeChTDS7IYXWG%2FOn0DuEyZUL%2BGlz7vZW7TR3aG5RszABymUqUwcyRR7IOGGCp4Esnn4kkqw0NGGkdY%2BxCzZtE9ArqDOGSeqJRnA%2FRcNuSNP%2F5oYtqDrImnRnqDeLtmMfYKCq9SCq0eyzDRRlomR%2FQ8GOUqs9C5k%2FrTJy%2BudquQtd3cUoY8AQwj%2BqSswY6sQGCnw79pxncBACAP7DH%2BF%2F%2BwA8ICyJQE7yU0yp%2F9TNHbTui4tyf6db97WlKw43LkA7Ebr09Ij462GWV8HownsP5zHxrk3Eej9AI8BDVxqrS8i5ENyobeTpp3u7F8Yyrm83CxBMe36TjHcL7UnrCMwvXPerzdwdvr4fyhFpVPbU7MZS4Ng52xOYoJEe9dc349pFWN2Mcp%2FJZSsIL6eMoM0LF2%2BJ4lOYYraw65gwxBqQg81U%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240608T212231Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFOWCC6ISB%2F20240608%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=03a83357e9bce3bc558ad878ad1b34e190dbe5c53a529515c1a3c3bc78932d2a')
  end

  it 'returns an empty array when a country with no recipes is entered' do
    json_response = File.read('spec/fixtures/tokelau_recipes.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=tokelau&app_id=08e8c11c&app_key=#{Rails.application.credentials.edamam[:key]}").to_return(status: 200, body: json_response)

    get '/api/v1/recipes?country=tokelau'

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data].empty?).to eq (true)
  end

  it 'returns an empty array if no country is passed in' do
    json_response = File.read('spec/fixtures/no_recipes.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=&app_id=08e8c11c&app_key=#{Rails.application.credentials.edamam[:key]}").to_return(status: 200, body: json_response)

    get "/api/v1/recipes?country="

    expect(response).to be_successful
    expect(response.status).to eq (200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json).to be_a (Hash)
    expect(parsed_json.keys.count).to eq (1)
    expect(parsed_json).to have_key (:data)
    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data].empty?).to eq (true)
  end
end