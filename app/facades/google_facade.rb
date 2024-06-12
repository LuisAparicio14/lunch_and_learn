class GoogleFacade
  def get_video(searched_for_country)
    service = GoogleService.new
    response = service.get_video_from_query(searched_for_country)
    new_learning_resource = LearningResource.new({
      country: searched_for_country,
      video: Hash.new,
      images: Array.new
    })

    if !response[:items][0].nil?
      new_learning_resource.video[:title] = response[:items][0][:snippet][:title]
      new_learning_resource.video[:youtube_video_id] = response[:items][0][:id][:videoId]
    end

    new_learning_resource
  end
end