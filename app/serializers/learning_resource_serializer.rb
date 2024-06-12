class LearningResourceSerializer
  def serialized_json(learning_resource)
    {
      "data":
        {
          "id": nil,
          "type": "learning_resource",
          "attributes": {
            "country": "#{learning_resource.country}",
            "video": learning_resource.video,
            "images": learning_resource.images
          }
        }
    }
  end
end