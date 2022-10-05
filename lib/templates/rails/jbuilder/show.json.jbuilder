<% namespace_name = controller_class_name.split("::") -%>
<% namespace_name = namespace_name.size > 1 ? namespace_name[0, namespace_name.size - 1] : [] -%>
<% singular_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% partial_path_name = [controller_file_path, singular_table_name].join('/') -%>
# frozen_string_literal: true

<% partial_path_name = [controller_file_path, singular_table_name].join('/') -%>
json.partial! '<%= partial_path_name %>', <%= singular_table_name %>: @<%= singular_table_name %>
