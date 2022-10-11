# frozen_string_literal: true

<% has_account_id = attributes.select{ |attribute| attribute.name == 'account' }.any? -%>
<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
<% if has_account_id -%>
  include Accountable

<% end -%>
<% attributes.select(&:reference?).each do |attribute| -%>
  <%- next if attribute.name == 'account' -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
<% end -%>
<% attributes.select(&:token?).each do |attribute| -%>
  has_secure_token<% if attribute.name != "token" %> :<%= attribute.name %><% end %>
<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>

<% attributes.each do |attribute| -%>
<% if attribute.type == :string -%>
  validates :<%= attribute.name %>, length: { maximum: <%= ! attribute.attr_options[:limit].nil? ? attribute.attr_options[:limit] : 255 %> }
<% elsif attribute.type == :integer -%>
  validates :<%= attribute.name %>, numericality: { only_integer: true }
<% end -%>
<% end -%>
end
<% end -%>
