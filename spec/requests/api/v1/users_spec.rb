# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users', type: :request do
  # include_context 'with auth headers'

  let(:auth_headers) { {} }

  let!(:user) { create(:user) }
  let(:user_params) { build(:user).attributes }

  describe 'GET /users' do
    before { get api_v1_users_url, headers: auth_headers }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body.first['id']).to eq(user.id) }
  end

  describe 'GET /users/:id' do
    context 'with valid params' do
      before { get api_v1_user_url(user), headers: auth_headers }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.parsed_body['id']).to eq(user.id) }
    end

    context 'with invalid params' do
      before { get api_v1_user_url(0), headers: auth_headers }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /users' do
    it 'creates user' do
      post api_v1_users_url, params: { user: user_params }, headers: auth_headers
      expect(response).to have_http_status(:created)
    end

    it 'does not create user with invalid params' do
      post api_v1_users_url, params: { user: user_params.except('full_name') },
        headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /users/:id' do
    context 'with valid params' do
      before do
        request_params = { user: { full_name: 'fake company' } }
        patch api_v1_user_url(user), params: request_params, headers: auth_headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.parsed_body['full_name']).to eq('fake company') }
    end

    context 'with invalid params' do
      before do
        request_params = { user: { full_name: nil } }
        patch api_v1_user_url(user), params: request_params, headers: auth_headers
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /users/:id' do
    it 'destroys user' do
      delete api_v1_user_url(user), headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
