# frozen_string_literal: true
module Api
  module V1
    class UsersController < ResourcesController
      def resource_params
        params.permit(:email, :role)
      end
    end
  end
end
