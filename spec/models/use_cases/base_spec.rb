require 'rails_helper'

RSpec.describe UseCases::Base do
  it 'raise NotImplementedError' do
    expect { UseCases::Base.call }
      .to raise_error(NotImplementedError, 'Not implemented yet')
  end
end
