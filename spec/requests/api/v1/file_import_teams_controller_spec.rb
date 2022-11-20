# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::FileImportTeams', type: :request do
  include_context 'with auth headers'

  describe 'POST /create' do
    before do
      file = fixture_file_upload('csv/teams/with_semicolon.csv')

      create(:file_import_manager, file:)
    end

    let(:params) do
      { file_import_manager: { file: FileImportManager.first.file.signed_id } }
    end

    it 'returns http created' do
      post api_v1_file_import_teams_path,
        params: params,
        headers: auth_headers,
        as: :json

      expect(response).to have_http_status(:created)
    end

    it 'will enqueue FileImportTeamJob' do
      post api_v1_file_import_teams_path,
        params: params,
        headers: auth_headers,
        as: :json

      expect(FileImportTeamJob).to(
        have_been_enqueued.with(FileImportManager.last.id)
      )
    end
  end
end
