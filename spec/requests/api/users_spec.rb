require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '#create' do
    context 'when providing valid parameters' do
      let(:registration_params) { {
        user: {
          email: "test@test.com",
          password: "123456"
        }
      } }

      it 'returns 201 on success' do
        post api_user_path, params: registration_params

        expect(response).to have_http_status(201)
      end

      it 'creates a new user' do
        expect {
          post api_user_path, params: registration_params
        }.to change(User, :count).by(1)
      end

      it 'returns a JWT token' do
        post api_user_path, params: registration_params

        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key("token")
      end
    end

    context 'when providing invalid parameters' do
      let(:registration_params) { {
        user: {
          email: nil,
          password: nil
        }
      } }

      it 'returns 422 on failure' do
        post api_user_path, params: registration_params

        expect(response).to have_http_status(422)
      end

      it 'does not create a new user with the provided data' do
        expect {
          post api_user_path, params: registration_params
        }.not_to change(User, :count)
      end
    end
  end

  describe '#details' do
    context 'user is authenticated' do
      let!(:user) { create(:user, :with_game_events, game_events_count: 5) }

      it 'returns 200 on success' do
        get api_user_path, headers: auth_headers(user)

        expect(response).to have_http_status(200)
      end

      it 'formats the user data correctly' do
        get api_user_path, headers: auth_headers(user)

        user_data = JSON.parse(response.body)['user']
        expect(user_data).to include({ 'id' => user.id })
        expect(user_data).to include({ 'email' => user.email })
        expect(user_data).to include({ 'stats' => { 'total_games_played' => user.total_games_played } })
      end
    end

    context 'user is not authenticated' do
      it 'returns 401 on failure' do
        get api_user_path, headers: {}

        expect(response).to have_http_status(401)
      end
    end
  end
end
