# frozen_string_literal: true

class Api::V1::FileImportManagersController < ApplicationController
  def index
    @file_import_managers = FileImportManager.all
  end
end
