class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    return render json: { error: 'Invalid token' }, status: :unauthorized unless auth_header.present?

    token = auth_header.split(' ').last
    begin
      decoded_token = JWT.decode(
        token, 
        Rails.application.credentials.fetch(:secret_key_base),
        true, 
        { algorithm: 'HS256' }
      )

      payload = decoded_token.first
      user = User.find(payload['sub'])

      if user && user.jti == payload['jti']
        @current_user = user
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    rescue JWT::ExpiredSignature
      render json: { error: 'Token has expired' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def auth_header
    request.headers['Authorization']
  end
end
