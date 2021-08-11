class Api::V1::UsersController < ApplicationController
  def create
    user_params[:email] = user_params[:email].downcase
    params[:password_confirmation] = '' if params[:password_confirmation].nil?
    begin
      @new_user = User.create!(user_params)
      ApiKey.create(user_id: @new_user.id, token: ApiKey.generate_new)
      json_response(UserSerializer.new(@new_user), :created)
    rescue ActiveRecord::RecordInvalid => e
      json_response({ errors: e.message }, :unprocessable_entity)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
