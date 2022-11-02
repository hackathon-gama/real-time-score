# frozen_string_literal: true

class Api::V1::FileImportTeamsController < ApplicationController
  def create
    @file_import_manager = FileImportManager.create!(file_import_manager_params)

    head :created
  end

  private

  def file_import_manager_params
    params.require(:file_import_manager).permit(:file)
  end
end
