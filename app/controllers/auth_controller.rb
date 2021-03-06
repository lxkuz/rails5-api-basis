# frozen_string_literal: true
class AuthController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_password?(params[:password])
      if user.confirmed?
        render json: payload(user)
      else
        render json: { errors: ['Confirm email, please'] }, status: :unauthorized
      end
    else
      render json: { errors: ['Invalid Email/Password'] }, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil if user.nil?
    {
      user: UserSerializer.new(user),
      auth_token: JsonWebToken.encode(user.attributes.slice('id', 'email'))
    }
  end
end
