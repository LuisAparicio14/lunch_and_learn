class Recipe
  attr_reader :title, :url, :country, :image
  
  def initialize(data_hash)
    @title = data_hash[:title]
    @url = data_hash[:url]
    @country = data_hash[:country]
    @image = data_hash[:image]
  end
end