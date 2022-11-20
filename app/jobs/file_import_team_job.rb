# frozen_string_literal: true

require 'file_extractors/csv_extractor'

class FileImportTeamJob < ApplicationJob
  queue_as :default

  AVALIABLE_EXTRACTORS = {
    'csv' => CSVExtractor
  }.freeze

  def perform(file_import_manager_id)
    @file_import_manager = FileImportManager.find(file_import_manager_id)

    return unless @file_import_manager.can_run?

    @file_import_manager.start!

    ActiveRecord::Base.transaction do
      UseCases::FileTeamCreator
        .call(file_extractor, permited_attributes: %w[name description])
    end

    @file_import_manager.done!
  end

  private

  def file_extractor
    file_extractor_klass =
      AVALIABLE_EXTRACTORS.fetch(file_import_manager.file_extension, nil)

    raise_invalid_file_extension unless file_extractor_klass

    file_extractor_klass.new(file_import_manager.file.download)
  end

  def raise_invalid_file_extension
    keys = AVALIABLE_EXTRACTORS.keys.join(', ')

    raise(TypeError, "file extension must be in: (#{keys})")
  end

  attr_reader :file_import_manager
end
