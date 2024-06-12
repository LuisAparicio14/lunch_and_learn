require 'rails_helper'

RSpec.describe EdamamService do
  it 'exists' do
    service = EdamamService.new

    expect(service).to be_a (EdamamService)
  end

  it '#get_recipes_from_query(searched_for_country)' do
    service = EdamamService.new

    json_response = File.read('spec/fixtures/thailand_recipes.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=thailand&app_id=08e8c11c&app_key=#{Rails.application.credentials.edamam[:key]}").to_return(status: 200, body: json_response)

    result = service.get_recipes_from_query('thailand')

    expect(result).to be_a (Hash)
    expect(result[:hits][0]).to be_a (Hash)
    expect(result[:hits][0][:recipe][:label]).to eq ('Steamed Thailand Turkey Burger')
    expect(result[:hits][0][:recipe][:url]).to eq ('https://food52.com/recipes/21104-steamed-thailand-turkey-burger')
    expect(result[:hits][0][:recipe][:image]).to eq ('https://edamam-product-images.s3.amazonaws.com/web-img/d7a/d7aadde1ff6875e8d46f46c692691d73.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEH4aCXVzLWVhc3QtMSJHMEUCIFTVBHngbcaSrnlUA5aTGI%2FgOfQ90CfHNOPBjl6ZMKGRAiEA4mYxrk59ijZcAbyRJ4oiRsmEfQsYU9XEXp27LliJJnsquQUIFxAAGgwxODcwMTcxNTA5ODYiDIYHIARUNghRCW3kqiqWBS3hqgY74to%2FIHu0dNWe3MmG50R%2FQ6halJb1KnrLFmhUr2B9XGZoF4mw%2FDwEaWzqAr9HQ1wXOJU2g54PJZKA%2BNlErzJ1OFk0%2BJZLLJeerlkHMpvxWNbe9rIH4uckfVxD2Rak%2BmQBgIBH5mL96uBj5l%2BQsAOt32A20G3lv%2Bbj1VoB2pZS6qOAAWS6EITzz2x2Z9uQ15bRCM4JlRfQHHl%2BaC64%2BIXyPvN7B3rD1Lx6OgOW3p0v0ap3DSBv%2B8QSpG9CfAU%2FxAm8wPhwUVhgmpwT27JiPteYu0DzPyjVrNPytawhCh7LCiyk61YS8KqBiKiZkRY6lcwrw1MEg70V5ZaA3l6zD7GhoEgK06M7o19ubwg8Fm56rSJfQXRkVgeXnWSy7SMXsjnw3%2B6plpdjCDHAgww3N0qQiSgMbhgCrDR%2FVqPzIOM7tj%2BLNOucUjg9lteJITQwj%2BDiAffLqAVAY125RB4ufwDmDvKGvgaK4MkPpMxL64WF0k0o6ctdD1IG1F%2B0WhqLdrC9stfJwpXsycSOg0tw3EOQr%2FzVz5bt%2FW0xgus%2FlmHx%2BnHLtrTPGJIwdFQ%2B2BXhK26qBwxItgw4WPqWUv40URdzHg6RfvfibktveI8t5ubgnLVZFegZJ3Sc5Q4ZyJCZq3GjgjI4cbRFbFn%2FKgKCARiyOh9gI3AXqwtaAfitMj1gkW5NlScWw8Fljm1Q7FvaeufcBlAQtHH3l%2BGol%2FTmWyRPHw0B8pY8FtbT863Ojv%2BLNbPdU%2BAHlJF6K6R9ohvqyqx6Gr8ahSv7lp%2BUL80ZofC%2FGl3lEPf93x8FQmf1JLWRffsqbkikhChhdQ6CV2mIZ3STqfMP0uTbqPD%2FQ8E7ZrJRBxR1AczfcVXShiYxkHcdP7LoMM24kbMGOrEBe0au2JH50qGaHIo80a%2BXzTDgAdLA6pqQe03ESINcTqeUVEHaTqU73nzb7%2FGw3aAcmsZ26VSpRiwXt%2BR4SkCx0Gn2mdQh5EJwe8hilaoq3yEeBhfaD%2BMHmnuR%2Fxvi3a5bvdd7pHhe0nahZT5XHl2Ogiy4vXN3TWeIyvJ45JDRhDLiWAriE7mMLttSSUHN%2FSitKRphDtaKD2RtpPXERU%2FbQjbXpgIEoUld96129xqsqT1Q&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240608T140649Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIIOKD7VB%2F20240608%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=7416cd482ebc431e4f8d4ca56803ee9dbcefd0806cf1e51290a638441873e428')
  end

  it '#get_url(url)' do
    service = EdamamService.new

    json_response = File.read('spec/fixtures/thailand_recipes.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=thailand&app_id=08e8c11c&app_key=#{Rails.application.credentials.edamam[:key]}").to_return(status: 200, body: json_response)

    result = service.get_url('/api/recipes/v2?type=public&q=thailand')

    expect(result).to be_a (Hash)
    expect(result[:hits][0]).to be_a (Hash)
    expect(result[:hits][0][:recipe][:label]).to eq ('Steamed Thailand Turkey Burger')
    expect(result[:hits][0][:recipe][:url]).to eq ('https://food52.com/recipes/21104-steamed-thailand-turkey-burger')
    expect(result[:hits][0][:recipe][:image]).to eq ('https://edamam-product-images.s3.amazonaws.com/web-img/d7a/d7aadde1ff6875e8d46f46c692691d73.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEH4aCXVzLWVhc3QtMSJHMEUCIFTVBHngbcaSrnlUA5aTGI%2FgOfQ90CfHNOPBjl6ZMKGRAiEA4mYxrk59ijZcAbyRJ4oiRsmEfQsYU9XEXp27LliJJnsquQUIFxAAGgwxODcwMTcxNTA5ODYiDIYHIARUNghRCW3kqiqWBS3hqgY74to%2FIHu0dNWe3MmG50R%2FQ6halJb1KnrLFmhUr2B9XGZoF4mw%2FDwEaWzqAr9HQ1wXOJU2g54PJZKA%2BNlErzJ1OFk0%2BJZLLJeerlkHMpvxWNbe9rIH4uckfVxD2Rak%2BmQBgIBH5mL96uBj5l%2BQsAOt32A20G3lv%2Bbj1VoB2pZS6qOAAWS6EITzz2x2Z9uQ15bRCM4JlRfQHHl%2BaC64%2BIXyPvN7B3rD1Lx6OgOW3p0v0ap3DSBv%2B8QSpG9CfAU%2FxAm8wPhwUVhgmpwT27JiPteYu0DzPyjVrNPytawhCh7LCiyk61YS8KqBiKiZkRY6lcwrw1MEg70V5ZaA3l6zD7GhoEgK06M7o19ubwg8Fm56rSJfQXRkVgeXnWSy7SMXsjnw3%2B6plpdjCDHAgww3N0qQiSgMbhgCrDR%2FVqPzIOM7tj%2BLNOucUjg9lteJITQwj%2BDiAffLqAVAY125RB4ufwDmDvKGvgaK4MkPpMxL64WF0k0o6ctdD1IG1F%2B0WhqLdrC9stfJwpXsycSOg0tw3EOQr%2FzVz5bt%2FW0xgus%2FlmHx%2BnHLtrTPGJIwdFQ%2B2BXhK26qBwxItgw4WPqWUv40URdzHg6RfvfibktveI8t5ubgnLVZFegZJ3Sc5Q4ZyJCZq3GjgjI4cbRFbFn%2FKgKCARiyOh9gI3AXqwtaAfitMj1gkW5NlScWw8Fljm1Q7FvaeufcBlAQtHH3l%2BGol%2FTmWyRPHw0B8pY8FtbT863Ojv%2BLNbPdU%2BAHlJF6K6R9ohvqyqx6Gr8ahSv7lp%2BUL80ZofC%2FGl3lEPf93x8FQmf1JLWRffsqbkikhChhdQ6CV2mIZ3STqfMP0uTbqPD%2FQ8E7ZrJRBxR1AczfcVXShiYxkHcdP7LoMM24kbMGOrEBe0au2JH50qGaHIo80a%2BXzTDgAdLA6pqQe03ESINcTqeUVEHaTqU73nzb7%2FGw3aAcmsZ26VSpRiwXt%2BR4SkCx0Gn2mdQh5EJwe8hilaoq3yEeBhfaD%2BMHmnuR%2Fxvi3a5bvdd7pHhe0nahZT5XHl2Ogiy4vXN3TWeIyvJ45JDRhDLiWAriE7mMLttSSUHN%2FSitKRphDtaKD2RtpPXERU%2FbQjbXpgIEoUld96129xqsqT1Q&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240608T140649Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFIIOKD7VB%2F20240608%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=7416cd482ebc431e4f8d4ca56803ee9dbcefd0806cf1e51290a638441873e428')
  end

  it '#api_connection' do
    service = EdamamService.new

    result = service.api_connection

    expect(result).to be_a (Faraday::Connection)
    expect(result.params[:app_id]).to eq ('08e8c11c')
    expect(result.params[:app_key]).to eq (Rails.application.credentials.edamam[:key])
  end
end