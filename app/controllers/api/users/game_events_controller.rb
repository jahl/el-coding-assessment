module Api
  module Users
    class GameEventsController < ApplicationController
      def create
        begin
          game_event = @current_user.game_events.create!(game_event_params.merge({
            event_type: game_event_params[:event_type]&.downcase
          }))

          render json: { game_event: game_event }, status: :created
        rescue ActionController::ParameterMissing, ActiveRecord::RecordInvalid => e
          render json: { errors: e.message }, status: :unprocessable_entity
        end
      end

      private

      def game_event_params
        params.require(:game_event).permit(:game_id, :event_type, :occurred_at)
      end
    end
  end
end