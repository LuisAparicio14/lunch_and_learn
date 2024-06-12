class Api::V1::TouristSitesController < ApplicationController
  def index
    geoapify_facade = GeoapifyFacade.new
    top_10_tourist_sites = geoapify_facade.get_coordinates(params[:country])

    render json: TouristSiteSerializer.new.serialized_json(top_10_tourist_sites), status: 200
  end
end