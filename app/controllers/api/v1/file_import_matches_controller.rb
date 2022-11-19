# frozen_string_literal: true

class Api::V1::FileImportMatchesController < Api::V1::ApplicationController
  include FileImportManagerHandler
  private

  def execute_job
    FileImportMatchJob.perform_later(@file_import_manager.id)
  end
end
