# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::Serialization
  include JWTAuthorization
  include CanCan::ControllerAdditions

  respond_to :json
  rescue_from CanCan::AccessDenied, with: :render_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_access_denied
    render json: { errors: 'Access denied' }, status: 403
  end

  def render_not_found
    render json: { errors: 'Record not found' }, status: 404
  end
end
