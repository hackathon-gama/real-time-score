require 'file_extractors/base_extractor'

describe BaseExtractor do
  it 'should raise NotImplementedError' do
    expect { BaseExtractor.new('file').execute }
      .to raise_error(NotImplementedError, 'Not implemented yet')
  end
end
