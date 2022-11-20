# frozen_string_literal: true

class Api::V1::FileImportTeamsController < Api::V1::ApplicationController
  include FileImportManagerHandler

  private

  def execute_job
    FileImportTeamJob.perform_later(@file_import_manager.id)
  end
end
