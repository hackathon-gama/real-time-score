<% namespace_name = controller_class_name.split("::") -%>
<% namespace_name = namespace_name.size > 1 ? namespace_name[0, namespace_name.size - 1] : [] -%>
<% singular_table_with_namespace = "#{namespace_name.join('_').downcase}_#{singular_table_name}" if namespace_name.any? -%>
<% singular_table_with_namespace ||= singular_table_name -%>
<% partial_path_name = [controller_file_path, singular_table_name].join('/') -%>
# frozen_string_literal: true

json.extract! <%= singular_table_name %>, <%= full_attributes_list %>
<%- virtual_attributes.each do |attribute| -%>
<%- if attribute.type == :rich_text -%>
json.<%= attribute.name %> <%= singular_table_name %>.<%= attribute.name %>.to_s
<%- elsif attribute.type == :attachment -%>
json.<%= attribute.name %> url_for(<%= singular_table_name %>.<%= attribute.name %>)
<%- elsif attribute.type == :attachments -%>
json.<%= attribute.name %> do
  json.array!(<%= singular_table_name %>.<%= attribute.name %>) do |<%= attribute.singular_name %>|
    json.id <%= attribute.singular_name %>.id
  end
end
<%- end -%>
<%- end -%>
