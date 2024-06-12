class Api::V1::FavoritesController < ApplicationController
  def index
    if user = User.find_by(api_key: params[:api_key])
      render json: FavoriteSerializer.new.serialized_json(user.favorites), status: 200
    else
      render json: { "error": "No user found with that key" }, status: 400
    end
  end

  def create
    if user = User.find_by(api_key: params[:api_key])
      new_favorite = user.favorites.create!(
        country: params[:country],
        recipe_link: params[:recipe_link],
        recipe_title: params[:recipe_title]
      )
      render json: { "success": "Favorite added successfully" }, status: 201
    else
      render json: { "error": "No user found with that key" }, status: 400
    end
  end
end