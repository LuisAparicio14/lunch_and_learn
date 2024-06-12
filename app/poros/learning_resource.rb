class LearningResource
  attr_reader :country, :video, :images
  
  def initialize(data_hash)
    @country = data_hash[:country]
    @video = data_hash[:video]
    @images = data_hash[:images]
  end
end