class Api::V1::UsersController < ApplicationController
  def create
    user_params[:email] = user_params[:email].downcase
    @new_user = User.new(user_params)
    if @new_user.save
      # require 'pry'; binding.pry
      ApiKey.create(user_id: @new_user.id, token: ApiKey.generate_new)
      # render json response with the user and their api key (serialize user model but only with emial and key)
      json_response(UserSerializer.new(@new_user), :created)
    # else 
      # render an error message 
    end
  end

  private
  
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
