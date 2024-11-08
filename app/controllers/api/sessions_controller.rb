module Api
  class SessionsController < ApplicationController
    include ::Auth::JwtTokenGenerator
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def create
      begin
        user = User.find_by(email: log_in_params[:email])

        raise 'Invalid email or password' unless user.valid_password?(log_in_params[:password])
        render json: { token: generate_token(user) }
      rescue => e
        render json: { error: e.message }, status: :unauthorized
      end
    end

    def destroy
      begin
        @current_user.update(jti: SecureRandom.uuid)
        render json: { message: 'Logged out successfully' }
      rescue
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end

    private

    def log_in_params
      params.require(:user).permit(:email, :password)
    end
  end
end