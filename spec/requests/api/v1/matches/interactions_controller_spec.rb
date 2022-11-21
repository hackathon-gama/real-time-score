# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Matches::Interactions', type: :request do
  include_context 'with auth headers'

  describe 'POST /create' do
    let(:match) { create(:match) }
    let(:params) do
      {
        description: Faker::Lorem.sentence,
        time: 1,
        minutes: 41,
        type: 'start'
      }
    end

    it 'returns http created' do
      post api_v1_match_interactions_path(match),
        params: params,
        headers: auth_headers,
        as: :json

      expect(response).to have_http_status(:created)
    end

    context 'when sending invalid params' do
      it 'sending invalid type' do
        params[:type] = 'invalid_type'

        post api_v1_match_interactions_path(match),
          params: params,
          headers: auth_headers,
          as: :json

        expect(response).to have_http_status(:bad_request)
      end

      it 'sending invalid attribute' do
        params[:time] = 0

        post api_v1_match_interactions_path(match),
          params: params,
          headers: auth_headers,
          as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
