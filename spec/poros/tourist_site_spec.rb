require 'rails_helper'

RSpec.describe TouristSite do
  it 'exists and can initialize' do
    tourist_site = TouristSite.new({
      name: 'Calvaire',
      address: 'Calvaire, Place des Combattants en AFN, 36230 Sarzay, France',
      place_id: '51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265'
    })

    expect(tourist_site).to be_a TouristSite
    expect(tourist_site.name).to eq('Calvaire')
    expect(tourist_site.address).to eq('Calvaire, Place des Combattants en AFN, 36230 Sarzay, France')
    expect(tourist_site.place_id).to eq('51038ef3ed1376fe3f5938edb7a7f54c4740f00103f901d5a50d050100000092030843616c7661697265')
  end
end