# frozen_string_literal: true
class ApplicationController < ActionController::API
  include ActionController::Serialization
  include CanCan::ControllerAdditions

  respond_to :json
  rescue_from CanCan::AccessDenied, with: :render_access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  attr_reader :current_user

  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def authenticate_request
    return unless user_id_in_token?
    @current_user = User.find(auth_token[:id])
  rescue JWT::VerificationError, JWT::DecodeError
    return
  end

  private

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:id].to_i
  end

  def render_access_denied
    render json: { errors: [t('labels.access_denied')] }, status: 406
  end

  def render_not_found
    render json: { errors: [t('labels.record_not_found')] }, status: 406
  end
end
