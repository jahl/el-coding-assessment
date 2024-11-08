require 'rails_helper'

RSpec.describe 'GameEvents', type: :request do
  describe '#create' do
    let!(:user) { create(:user) }

    context 'when providing valid parameters' do
      let(:game) { create(:game) }
      let(:game_events_params) { {
        game_event: {
            event_type: "COMPLETED",
            game_id: game.id,
            occurred_at: "2024-11-08T00:36:48+00:00"
        }
      } }

      it 'returns 201 on success' do
        post api_users_game_events_path, params: game_events_params, headers: auth_headers(user)

        expect(response).to have_http_status(201)
      end

      it 'creates a new event' do
        expect { 
          post api_users_game_events_path, params: game_events_params, headers: auth_headers(user)
         }.to change(GameEvent, :count).by(1)
      end
    end

    context 'when providing invalid parameters' do
      let(:game_events_params) { {
        game_event: {
            event_type: "Something",
            game_id: -1,
            occurred_at: nil
        }
      } }

      it 'returns 422 on failure' do
        post api_users_game_events_path, params: game_events_params, headers: auth_headers(user)

        expect(response).to have_http_status(422)
      end

      it 'does not create a new event' do
        expect { 
          post api_users_game_events_path, params: game_events_params, headers: auth_headers(user)
         }.to change(GameEvent, :count).by(0)
      end
    end

    context 'when user is not authenticated' do
      it 'does not create a new event' do
        post api_users_game_events_path, params: {}
        expect(response).to have_http_status(401)
      end
    end
  end
end
