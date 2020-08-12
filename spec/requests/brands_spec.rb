require 'rails_helper'

RSpec.describe '/brands', type: :request do
  let(:admin) { create(:user) }
  let!(:brand) { create(:brand) }
  let(:valid_headers) { { Authorization: access_token(admin) } }
  let(:valid_attributes) { attributes_for(:brand) }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET /index' do
    before { get '/api/brands' }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it { is_expected.not_to be_empty }
  end

  describe 'GET /show' do
    context 'with admin role' do
      before { get "/api/brands/#{brand.id}", headers: valid_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without login' do
      before { get "/api/brands/#{brand.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before { post '/api/brands', params: { brand: valid_attributes }, headers: valid_headers, as: :json }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before { post '/api/brands', params: { brand: invalid_attributes }, headers: valid_headers, as: :json }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without login' do
      before { post '/api/brands', params: { brand: valid_attributes }, as: :json }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:brand) }

      before { patch "/api/brands/#{brand.id}", headers: valid_headers, params: { brand: new_attributes } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'update brand name' do
        expect(json_response['name']).to eq(new_attributes[:name])
      end
    end

    context 'with invalid parameters' do
      before { patch "/api/brands/#{brand.id}", headers: valid_headers, params: { brand: invalid_attributes } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without login' do
      let(:new_attributes) { attributes_for(:brand) }

      before { patch "/api/brands/#{brand.id}", params: { brand: new_attributes } }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with admin role' do
      before { delete "/api/brands/#{brand.id}", headers: valid_headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without login' do
      before { delete "/api/brands/#{brand.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
