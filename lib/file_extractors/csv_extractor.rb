# frozen_string_literal: true

require 'file_extractors/base_extractor'
require 'csv'

class CSVExtractor < BaseExtractor
  DEFAULT_OPTIONS = { col_sep: ';', headers: true, encoding: 'utf-8' }.freeze

  attr_accessor :options

  def initialize(file, options: DEFAULT_OPTIONS)
    @options = options

    super(file)
  end

  private

  def row_interaction(&block)
    CSV.parse(file, **options, &block)
  end

  def transform_row(row)
    row.to_h
  end
end
