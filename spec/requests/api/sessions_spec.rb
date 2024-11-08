require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Sessions', type: :request do
  describe '#create' do
    let!(:user) { create(:user, email: "test@test.com", password: "123456" ) }

    context 'when providing valid parameters' do
      let(:login_params) { {
        user: {
          email: user.email,
          password: user.password
        }
      } }

      it 'returns 200 on success' do
        post api_session_path, params: login_params

        expect(response).to have_http_status(200)
      end

      it 'returns a JWT token' do
        post api_session_path, params: login_params

        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key("token")
      end
    end

    context 'when providing invalid parameters' do
      let(:login_params) { {
        user: {
          email: user.email,
          password: "123457"
        }
      } }

      it 'returns 401 on failure' do
        post api_session_path, params: login_params

        expect(response).to have_http_status(401)
      end

      it 'does not return a JWT token' do
        post api_session_path, params: login_params

        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to_not have_key("token")
      end

      it 'returns an error in JSON format' do
        post api_session_path, params: login_params

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq('Invalid email or password')
      end
    end
  end

  describe '#destroy' do
    context 'when user has a valid active JWT' do
      let!(:user) { create(:user, email: "test@test.com", password: "123456" ) }

      it 'returns 200 on success' do
        delete api_session_path, headers: auth_headers(user)

        expect(response).to have_http_status(200)
      end
    end

    context 'when user has no valid active JWT' do
      it 'returns 401 on failure' do
        delete api_session_path, headers: {}

        expect(response).to have_http_status(401)
      end
    end
  end
end
