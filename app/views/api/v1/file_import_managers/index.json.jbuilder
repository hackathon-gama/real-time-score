# frozen_string_literal: true

json.data do
  json.array! @file_import_managers,
    partial: 'file_import_manager', as: :file_import_manager
end
