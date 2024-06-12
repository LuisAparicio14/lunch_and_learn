class TouristSite
  attr_reader :name, :address, :place_id
  
  def initialize(data_hash)
    @name = data_hash[:name]
    @address = data_hash[:address]
    @place_id = data_hash[:place_id]
  end
end