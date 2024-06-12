require 'rails_helper'

RSpec.describe UnsplashFacade do
  it 'exists' do
    facade = UnsplashFacade.new

    expect(facade).to be_a (UnsplashFacade)
  end

  it '#get_images(searched_for_country, learning_resource)' do
    facade = UnsplashFacade.new
    
    learning_resource = LearningResource.new({
      country: 'laos',
      video: Hash.new,
      images: Array.new
    })

    json_response = File.read('spec/fixtures/unsplash_photos.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?query=laos&client_id=#{Rails.application.credentials.unsplash[:key]}").to_return(status: 200, body: json_response)
    
    result = facade.get_images('laos', learning_resource)

    expect(result).to be_a (Array)
    expect(result[0][:id]).to eq ('yJ2SHIpNb9M')
    expect(result[0][:urls][:raw]).to eq ('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=M3w2MjA1ODN8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcxNzg5MTgyN3ww&ixlib=rb-4.0.3')
  end
end