# frozen_string_literal: true

require 'file_extractors/base_extractor'

describe BaseExtractor do
  it 'raise NotImplementedError' do
    expect { described_class.new('file').execute }
      .to raise_error(NotImplementedError, 'Not implemented yet')
  end
end
