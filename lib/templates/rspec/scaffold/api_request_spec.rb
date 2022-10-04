<% object_name = file_name -%>
<% plural_object_name = object_name.pluralize -%>
<% model_name = file_name -%>
# frozen_string_literal: true

require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe '/<%= name.underscore.pluralize %>', <%= type_metatag(:request) %> do
  include_context 'with auth headers'

  let(:<%= object_name %>) { create(:<%= object_name %>) }
  let(:<%= object_name %>_params) { build(:<%= object_name %>).attributes }

<% unless options[:singleton] -%>
  describe 'GET /<%= plural_object_name %>' do
    before { get <%= index_helper %>_url, headers: auth_headers }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body.first['id']).to eq(<%= object_name %>.id) }
  end

<% end -%>
  describe 'GET /<%= plural_object_name %>/:id' do
    context 'with valid params' do
      before { get <%= show_helper %>, headers: auth_headers }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.parsed_body['id']).to eq(<%= object_name %>.id) }
    end

    context 'with invalid params' do
      before { get <%= show_helper(0) %>, headers: auth_headers }

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /<%= plural_object_name %>' do
    it 'creates <%= object_name %>' do
      post <%= index_helper %>_url, params: { <%= object_name %>: <%= object_name %>_params }, headers: auth_headers
      expect(response).to have_http_status(:created)
    end

    it 'does not create <%= object_name %> with invalid params' do
      post <%= index_helper %>_url, params: { <%= object_name %>: <%= object_name %>_params.except('description') }, headers: auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH /<%= plural_object_name %>/:id' do
    context 'with valid params' do
      before do
        request_params = { <%= object_name %>: { description: 'fake company' } }
        patch <%= show_helper %>, params: request_params, headers: auth_headers
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.parsed_body['description']).to eq('fake company') }
    end

    context 'with invalid params' do
      before do
        request_params = { <%= object_name %>: { description: nil } }
        patch <%= show_helper %>, params: request_params, headers: auth_headers
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /<%= plural_object_name %>/:id' do
    it 'destroys <%= object_name %>' do
      delete <%= show_helper %>, headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
<% end -%>
