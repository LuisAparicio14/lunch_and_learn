class Api::V1::LearningResourcesController < ApplicationController
  def index
    google_facade = GoogleFacade.new
    learning_resource = google_facade.get_video(params[:country])
    unsplash_facade = UnsplashFacade.new
    images = unsplash_facade.get_images(params[:country], learning_resource)
    
    render json: LearningResourceSerializer.new.serialized_json(learning_resource), status: 200
  end
end