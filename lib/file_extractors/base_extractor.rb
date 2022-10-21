# frozen_string_literal: true

class BaseExtractor
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def execute(&block)
    transformed_data = []

    row_interaction do |row|
      transformed_row = transform_row(row)

      if block
        yield transformed_row
      else
        transformed_data << transformed_row
      end
    end

    transformed_data.any? ? transformed_data : nil
  end

  private

  def row_interaction(&block)
    raise(NotImplementedError, 'Not implemented yet')
  end

  def transform_row(_row)
    raise(NotImplementedError, 'Not implemented yet')
  end
end
