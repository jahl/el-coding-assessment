module Api
  class UsersController < ApplicationController
    include ::Auth::JwtTokenGenerator
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def create
      user = User.new(registration_params)

      if user.save
        render json: { token: generate_token(user) }, status: :created
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    def details
      render json: {
        user: {
          id: @current_user.id,
          email: @current_user.email,
          stats: {
            total_games_played: @current_user.total_games_played
          }
        }
      }
    end

    private

    def registration_params
      params.require(:user).permit(:email, :password)
    end
  end
end