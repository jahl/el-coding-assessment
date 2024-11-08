require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
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

      it 'creates a new user with the provided data' do
        post api_user_path, params: registration_params

        expect(User.last.email).to eq(registration_params[:user][:email])
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
end
