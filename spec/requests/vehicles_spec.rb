require 'rails_helper'

RSpec.describe '/vehicles', type: :request do
  let(:admin) { create(:user) }
  let!(:vehicle) { create(:vehicle) }
  let(:valid_headers) { { Authorization: access_token(admin) } }
  let(:valid_attributes) { attributes_for(:vehicle) }
  let(:invalid_attributes) { { value: '' } }

  describe 'GET /index' do
    before { get "/api/models/#{vehicle.model.id}/vehicles" }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it { is_expected.not_to be_empty }
  end

  describe 'GET /show' do
    context 'with admin role' do
      before { get "/api/vehicles/#{vehicle.id}", headers: valid_headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without login' do
      before { get "/api/vehicles/#{vehicle.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post "/api/models/#{vehicle.model.id}/vehicles", params: { vehicle: valid_attributes },
                                                         headers: valid_headers, as: :json
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'has a reference to model' do
        expect(json_response['model_id']).to eq(vehicle.model.id)
      end
    end

    context 'with invalid parameters' do
      before do
        post "/api/models/#{vehicle.model.id}/vehicles", params: { vehicle: invalid_attributes },
                                                         headers: valid_headers, as: :json
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without login' do
      before { post "/api/models/#{vehicle.model.id}/vehicles", params: { vehicle: valid_attributes }, as: :json }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) { attributes_for(:vehicle) }

    context 'with valid parameters' do
      before { patch "/api/vehicles/#{vehicle.id}", headers: valid_headers, params: { vehicle: new_attributes } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'update model name' do
        expect(json_response['name']).to eq(new_attributes[:name])
      end
    end

    context 'with invalid parameters' do
      before { patch "/api/vehicles/#{vehicle.id}", headers: valid_headers, params: { vehicle: invalid_attributes } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'without login' do
      before { patch "/api/vehicles/#{vehicle.id}", params: { vehicle: new_attributes } }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with admin role' do
      before { delete "/api/vehicles/#{vehicle.id}", headers: valid_headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without login' do
      before { delete "/api/vehicles/#{vehicle.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
