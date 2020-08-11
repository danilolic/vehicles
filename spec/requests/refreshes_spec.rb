require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }
  let(:session) { JWTSessions::Session.new(payload: { user_id: user.id, role: user.role }) }
  let(:refresh_token) { session.login[:refresh] }

  describe 'POST /api/refresh' do
    context 'with correct email and password' do
      before { post '/api/refresh', headers: { 'X-Refresh-Token': refresh_token }, params: { user_id: user.id } }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns access token' do
        expect(json_response).to have_key('access')
      end

      it 'returns refresh token' do
        expect(json_response).to have_key('access_expires_at')
      end
    end

    context 'with invalid password' do
      before do
        post '/api/refresh', headers: { 'X-Refresh-Token': 'wrong_refresh_token' },
                             params: { user_id: user.id }
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        expect(json_response['error']).to eq('Not authorized')
      end
    end
  end
end
