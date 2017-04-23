# frozen_string_literal: true
module Api
  module V1
    class UsersController < ResourcesController
      has_scope :order_by, default: 'created_at desc, role desc'

      def resource_params
        params.permit(:email, :role, :password)
      end
    end
  end
end
