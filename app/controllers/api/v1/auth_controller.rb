# frozen_string_literal: true
module Api
  module V1
    class AuthController < ApplicationController
      def authenticate_user
        user = User.find_for_database_authentication(email: params[:email])
        if user && user.valid_password?(params[:password])
          render json: payload(user)
        else
          render json: { errors: ['Invalid Email/Password'] }, status: :unauthorized
        end
      end

      private

      def payload(user)
        return nil if user.nil?
        {
          user: ::UserSerializer.new(user),
          auth_token: JsonWebToken.encode(user.attributes.slice('id', 'email'))
        }
      end
    end
  end
end
