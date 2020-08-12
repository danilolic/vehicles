require 'rails_helper'

RSpec.describe '/models', type: :request do
  let(:admin) { create(:user) }
  let!(:model) { create(:model) }
  let(:valid_headers) { { Authorization: access_token(admin) } }
  let(:valid_attributes) { attributes_for(:model) }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET /index' do
    before { get "/api/brands/#{model.brand.id}/models" }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it { is_expected.not_to be_empty }
  end

  describe 'GET /show' do
    context 'with admin role' do
      before { get "/api/models/#{model.id}", headers: valid_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without login' do
      before { get "/api/models/#{model.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post "/api/brands/#{model.brand.id}/models", params: { model: valid_attributes },
                                                     headers: valid_headers, as: :json
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'has a reference to brand' do
        expect(json_response['brand_id']).to eq(model.brand.id)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/brands/#{model.brand.id}/models", params: { model: invalid_attributes },
                                                     headers: valid_headers, as: :json
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without login' do
      before { post "/api/brands/#{model.brand.id}/models", params: { model: valid_attributes }, as: :json }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) { attributes_for(:model) }

    context 'with valid parameters' do
      before { patch "/api/models/#{model.id}", headers: valid_headers, params: { model: new_attributes } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'update model name' do
        expect(json_response['name']).to eq(new_attributes[:name])
      end
    end

    context 'with invalid parameters' do
      before { patch "/api/models/#{model.id}", headers: valid_headers, params: { model: invalid_attributes } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without login' do
      before { patch "/api/models/#{model.id}", params: { model: new_attributes } }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with admin role' do
      before { delete "/api/models/#{model.id}", headers: valid_headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without login' do
      before { delete "/api/models/#{model.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
