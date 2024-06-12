class Api::V1::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      user = User.create(
        name: params[:name],
        email: params[:email],
        api_key: SecureRandom.base64.tr('+/=', 'Qrt'),
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )

      if !user.errors.blank?
        render json: { "error": "#{user.errors.full_messages.to_sentence}" }, status: 400
      elsif user.authenticate(params[:password])
        render json: UserSerializer.new.serialized_json(user), status: 201
      end
    else
      render json: { "error": "Passwords do not match" }, status: 400
    end
  end
end