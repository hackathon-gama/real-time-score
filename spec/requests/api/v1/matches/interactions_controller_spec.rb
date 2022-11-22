# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Matches::Interactions', type: :request do
  include_context 'with auth headers'

  describe 'GET /index' do
    let(:match) { create(:match) }
    let(:params) do
      {
        type: 'finish'
      }
    end

    before do
      create_list(:interaction_finisher, 2, match:)
    end

    it 'returns http ok' do
      get api_v1_match_interactions_path(match),
        params:,
        headers: auth_headers

      expect(response).to have_http_status(:ok)
    end

    it 'returns empty array in response body' do
      stage = create(:stage, name: 'final')

      get api_v1_match_interactions_path(create(:match, stage:)),
        params:,
        headers: auth_headers

      expect(response.parsed_body).to be_empty
    end

    it 'returns have two interactions in response body' do
      get api_v1_match_interactions_path(match),
        params:,
        headers: auth_headers

      expect(response.parsed_body.size).to eq(2)
    end
  end

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
        params:,
        headers: auth_headers,
        as: :json

      expect(response).to have_http_status(:created)
    end

    it 'will broadcast interactions in InteractionsChannel' do
      expect do
        post api_v1_match_interactions_path(match),
          params:,
          headers: auth_headers,
          as: :json
      end
        .to have_broadcasted_to("match_#{match.id}_interactions")
    end

    it 'will call #update_match in new interaction' do
      interaction = instance_double(Interaction::Starter)
      allow(Interaction::Starter).to receive(:create!).and_return(interaction)
      allow(InteractionSerializer).to receive(:new).and_return({})
      allow(interaction).to receive(:update_match)

      expect(interaction).to receive(:update_match)

      post api_v1_match_interactions_path(match),
        params:,
        headers: auth_headers,
        as: :json
    end

    context 'when sending invalid params' do
      it 'sending invalid type' do
        params[:type] = 'invalid_type'

        post api_v1_match_interactions_path(match),
          params:,
          headers: auth_headers,
          as: :json

        expect(response).to have_http_status(:bad_request)
      end

      it 'sending invalid attribute' do
        params[:time] = 0

        post api_v1_match_interactions_path(match),
          params:,
          headers: auth_headers,
          as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
