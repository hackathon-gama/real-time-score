# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::DirectUploads', type: :request do
  describe 'post /create' do
    let(:params) do
      {
        blob: {
          filename: Faker::File.file_name(name: 'image', ext: 'png'),
          byte_size: Faker::Number.number(digits: 10),
          checksum: Faker::Crypto.sha1,
          content_type: Faker::File.mime_type(media_type: 'image')
        }
      }
    end

    it 'return :ok status code' do
      post api_v1_direct_uploads_path, params: params

      expect(response).to have_http_status(:ok)
    end

    it 'return direct upload url' do
      post api_v1_direct_uploads_path, params: params

      expect(response.parsed_body.dig('direct_upload', 'url')).to be_present
    end
  end
end
