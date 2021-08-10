class Api::V1::UsersController < ApplicationController
  def create
    user_params[:email] = user_params[:email].downcase
    new_user = User.new(user_params)
    if new_user.save
      # generate an api key for that user and save it in some way that connects it to them
      # render json response with the user and their api key (serialize user model but only with emial and key)
    # else 
      # render an error message 
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
