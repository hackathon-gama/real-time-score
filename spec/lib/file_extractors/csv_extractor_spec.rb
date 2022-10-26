# frozen_string_literal: true

require 'rails_helper'
require 'file_extractors/csv_extractor'

describe CSVExtractor do
  context 'when CSV separator is a semicolon' do
    it 'will return hash with files values' do
      extractor = described_class.new(file_fixture('csv_with_semicolon.csv'))

      expect(extractor.execute)
        .to eq([
          { 'name' => 'Sao Paulo', 'description' => 'Tricolor paulista' },
          { 'name' => 'Grêmio', 'description' => 'Tricolor gaúcho' },
          { 'name' => 'Alético goianiense', 'description' => 'Dragão' }
        ])
    end
  end

  context 'when CSV separator is a comma' do
    it 'will return hash with files values' do
      extractor = described_class.new(file_fixture('csv_with_comma.csv'))
      extractor.options = extractor.options.merge(col_sep: ',')

      expect(extractor.execute)
        .to eq([
          { 'name' => 'Sao Paulo', 'description' => 'Tricolor paulista' },
          { 'name' => 'Grêmio', 'description' => 'Tricolor gaúcho' },
          { 'name' => 'Alético goianiense', 'description' => 'Dragão' }
        ])
    end
  end
end
