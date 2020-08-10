require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  describe 'POST /api/session' do
    context 'with correct email and password' do
      before { post '/api/session', params: { email: user.email, password: user.password } }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns access token' do
        expect(json_response).to have_key('access')
      end

      it 'returns refresh token' do
        expect(json_response).to have_key('refresh')
      end
    end

    context 'with invalid password' do
      before { post '/api/session', params: { email: user.email, password: 'wrong_password' } }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        expect(response.body).to eq('Invalid user')
      end
    end
  end
end
session