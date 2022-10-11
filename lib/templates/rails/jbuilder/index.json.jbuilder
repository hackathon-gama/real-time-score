<% namespace_name = controller_class_name.split("::") -%>
<% namespace_name = namespace_name.size > 1 ? namespace_name[0, namespace_name.size - 1] : [] -%>
<% singular_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% plural_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% partial_path_name = [controller_file_path, singular_table_name].join('/') -%>
# frozen_string_literal: true

json.array! @<%= plural_table_name %>, partial: '<%= partial_path_name %>', as: :<%= singular_table_name %>
