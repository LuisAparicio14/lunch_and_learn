class Api::V1::SessionsController < ApplicationController
  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        user_hash = {
          id: user.id,
          name: user.name,
          email: user.email,
          api_key: user.api_key
        }
        render json: UserSerializer.new.serialized_json(user_hash), status: 201
      else
        render json: { "error": "Bad credentials" }, status: 400
      end
    else
      render json: { "error": "User does not exist" }, status: 400
    end
  end
end