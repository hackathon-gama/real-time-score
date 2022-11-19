# frozen_string_literal: true

module FileImportManagerHandler
  extend ActiveSupport::Concern

  def create
    @file_import_manager = FileImportManager.create!(file_import_manager_params)

    execute_job

    head :created
  end

  private

  def file_import_manager_params
    params.require(:file_import_manager).permit(:file)
  end

  def execute_job
    raise(NotImplementedError, 'Method must be implemented')
  end
end
