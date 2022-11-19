# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::FileImportMaches', type: :request do
  include_context 'with auth headers'

  fdescribe 'POST /create' do
    before do
      file = fixture_file_upload('csv/teams/with_semicolon.csv')

      create(:file_import_manager, file: file)
    end

    let(:params) do
      { file_import_manager: { file: FileImportManager.first.file.signed_id } }
    end

    it 'returns http created' do
      post api_v1_file_import_matches_path,
        params: params,
        headers: auth_headers,
        as: :json

      expect(response).to have_http_status(:created)
    end

    it 'will enqueue FileImportMatchJob' do
      post api_v1_file_import_matches_path,
        params: params,
        headers: auth_headers,
        as: :json

      expect(FileImportMatchJob).to(
        have_been_enqueued.with(FileImportManager.last.id)
      )
    end
  end
end
