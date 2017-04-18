# frozen_string_literal: true
module Api
  module V1
    class UsersController < Api::V1::ResourcesController
      def resource_params
        params.permit(:email, :avatar, :first_name, :second_name,
                      :password, :password_confirmation, organization_ids: [])
      end
    end
  end
end
