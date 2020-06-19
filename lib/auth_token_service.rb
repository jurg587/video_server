class AuthTokenService
  class << self
    def encode(payload)
      payload[:exp] = 24.hours.from_now.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      HashWithIndifferentAccess.new JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    rescue
      nil
    end
  end
end