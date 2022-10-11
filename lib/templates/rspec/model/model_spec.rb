<% object_name = class_name.underscore -%>
<% references = attributes.select(&:reference?) -%>
# frozen_string_literal: true

require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:model) %> do
  subject(:<%= object_name %>) { build(:<%= object_name %>) }

<%- if references.any? -%>
  describe 'associations' do
<% references.each do |attribute| -%>
    it { is_expected.to belong_to(:<%= attribute.name %>) }
<% end -%>
  end

<%- end -%>
  describe 'validations' do
<% attributes.each do |attribute| -%>
<% if attribute.type == :string -%>
    it { is_expected.to validate_length_of(:<%= attribute.name %>).is_at_most(<%= ! attribute.attr_options[:limit].nil? ? attribute.attr_options[:limit] : 255 %>) }
<% end -%>
<% end -%>
  end

  describe '<%= object_name %> create' do
    before { <%= object_name %>.save }

    it { is_expected.to be_persisted }
  end
end
<% end -%>
