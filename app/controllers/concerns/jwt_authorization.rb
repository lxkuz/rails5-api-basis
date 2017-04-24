module JWTAuthorization
  extend ActiveSupport::Concern

  included do
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
  end
end
