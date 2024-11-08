module Auth
  module JwtTokenGenerator
    def generate_token(user)
      JWT.encode(
        {
          sub: user.id,
          jti: user.jti,
          exp: 24.hours.from_now.to_i,
          iat: Time.current.to_i
        },
        Rails.application.credentials.fetch(:secret_key_base)
      )
    end
  end
end
