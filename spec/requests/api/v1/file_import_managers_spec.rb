# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::FileImportManagers', type: :request do
  describe 'GET /index' do
    before do
      create_list(:file_import_manager, 2)
    end

    it 'returns http success' do
      get api_v1_file_import_managers_path, as: :json

      expect(response).to have_http_status(:success)
    end

    it 'return correct file_import_managers' do
      get api_v1_file_import_managers_path, as: :json

      ids = response.parsed_body['data'].map do |file_import_manager|
        file_import_manager['id']
      end

      expect(ids.sort).to eq(FileImportManager.last(2).map(&:id))
    end
  end
end
