require 'rails_helper'

RSpec.describe 'Entities API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:entities) {
    create_list(:entity, 4, :person)
    create_list(:entity, 3, :corporate_body)
    create_list(:entity, 3, :family)
  }
  let(:entity_id) { entities.first.id }
  
  # to authorize POST requests
  let(:headers) { valid_headers }

  # Test suite for GET /entities
  describe 'GET /entities' do
    before { get '/entities', params: {} }

    it 'returns entities' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /entities/:id
  describe 'GET /entities/:id' do
    before { get "/entities/#{entity_id}", params: {} }

    context 'when the record exists' do
      it 'returns the entity' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(entity_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:entity_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Entity/)
      end
    end
  end

  # Test suite for POST /entities
  describe 'POST /entities' do
    context 'when the request is valid' do
      let(:valid_attributes) { {
        "entity": {
          "entity_type": "person",
          "bioghist": "Henry Lowenstein is known as the Father of Denver Theatre.",
          "names_attributes": [{"name": "Lowenstein, Henry, 1925-2014", "form": "authorized"}]
        } }.to_json }

      before { post '/entities', params: valid_attributes, headers: headers }

      it 'creates an entity' do
        expect(json['authorized_name']).to eq('Lowenstein, Henry, 1925-2014')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {
        "entity": {
          "entity_type": "person",
          "names_attributes": []
        } }.to_json }

      before { post '/entities', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for POST /entities/:id
  describe 'POST /entities/:id' do
    let(:valid_attributes) { {
      "entity": { "bioghist": "This entity is full of contrasts" }
    }.to_json }

    before { post "/entities/#{entity_id}", params: valid_attributes, headers: headers }

    context 'when the record exists' do
      it 'updates the record' do
        expect(json['bioghist']).to match(/This entity is full of contrasts/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:entity_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Entity/)
      end
    end
  end

  # Test suite for DELETE /entities/:id
  describe 'DELETE /entities/:id' do
    before { delete "/entities/#{entity_id}", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
