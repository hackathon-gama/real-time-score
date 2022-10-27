# frozen_string_literal: true

shared_context 'with auth headers' do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, ENV['SECRET_KEY']) }
  let(:auth_headers) { { 'Authorization' => "Bearer #{token}" } }
end
