# frozen_string_literal: true
class UsersController < ResourcesController
  def resource_params
    params.permit(:email, :avatar, :first_name, :second_name,
                  :password, :password_confirmation, organization_ids: [])
  end
end
