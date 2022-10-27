# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users', type: :request do
  include_context 'with auth headers'

  let(:user_params) { build(:user).attributes }

  describe 'POST /users' do
    context 'creates user' do
      before do
        user_params['password'] = user_params['password_digest']
      end

      it 'with valid params' do
        post api_v1_users_url, params: { user: user_params }, headers: auth_headers
        expect(response).to have_http_status(:created)
      end

      it 'with invalid params' do
        post api_v1_users_url, params: { user: user_params.except('full_name') }, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
