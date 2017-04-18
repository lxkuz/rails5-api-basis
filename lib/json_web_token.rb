# frozen_string_literal: true
class JsonWebToken
  RELOAD_TIME = 1.day

  def self.encode(payload)
    payload[:timestamp] = (Time.now + JsonWebToken::RELOAD_TIME).to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    res = HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
    raise JWT::VerificationError if res[:timestamp].to_i < Time.now.to_i
    return res
  rescue
    nil
  end
end
