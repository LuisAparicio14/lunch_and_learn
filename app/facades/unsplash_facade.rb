class UnsplashFacade
  def get_images(searched_for_country, learning_resource)
    service = UnsplashService.new
    response = service.get_images_from_query(searched_for_country)
    images = response[:results][0..10].each do |photo|
      learning_resource.images << {
        alt_tag: photo[:alt_description],
        url: photo[:urls][:raw]
      }
    end
  end
end