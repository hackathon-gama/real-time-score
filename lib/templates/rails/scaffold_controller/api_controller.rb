# frozen_string_literal: true

<% namespace_name = controller_class_name.split("::") -%>
<% namespace_name = namespace_name.size > 1 ? namespace_name[0, namespace_name.size - 1] : [] -%>
<% singular_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% plural_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% route_url_sanitized = namespace_name.any? ? route_url.gsub("#{namespace_name.join('/').downcase}/", '') : route_url -%>
<% class_name_sanitized = namespace_name.any? ? class_name.gsub("#{namespace_name.join('::').downcase}::", '') : class_name -%>
<% index_helper_sanitized = namespace_name.any? ? index_helper.gsub("#{namespace_name.join('_').downcase}_", '') : index_helper -%>
<% namespace_name_not_admin = namespace_name.any? ? (namespace_name.first.downcase != 'admin' ? "#{namespace_name.join('_').downcase}_" : '') : '' -%>
<% attributes_names = attributes.map(&:name) - ['created_at', 'updated_at'] rescue [] -%>
<% has_account_id = attributes.select{ |attribute| attribute.name == 'account' }.any? -%>
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < <%= "#{namespace_name.join('::')}::" %>ApplicationController
  before_action :set_<%= singular_table_name %>, only: %i[show update destroy]

  def index
    @<%= plural_table_name %> = <%= plural_table_name.classify %>.all
  end

  def show; end

  def create
    @<%= singular_table_name %> = <%= plural_table_name.classify %>.new(<%= singular_table_name %>_params)

    if @<%= singular_table_name %>.save
      render :show, status: :created
    else
      render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity
    end
  end

  def update
    @<%= singular_table_name %>.update!(<%= singular_table_name %>_params)

    if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
      render :show, status: :ok
    else
      render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @<%= orm_instance.destroy %>
  end

  private

  def set_<%= singular_table_name %>
<% if has_account_id -%>
    @<%= singular_table_name %> = <%= singular_table_name.classify %>.find_by!(id: params[:id], account_id: current_account.id)
<% else -%>
    @<%= singular_table_name %> = <%= plural_table_name.classify %>.find(params[:id])
<% end -%>
  end

  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params[:<%= singular_table_name %>]
    <%- else -%>
    params.require(:<%= singular_table_name %>).permit(
      <%= attributes_names.map { |name| ":#{name}" }.join(",\n      ") %>
    )
    <%- end -%>
  end
end
<% end -%>
