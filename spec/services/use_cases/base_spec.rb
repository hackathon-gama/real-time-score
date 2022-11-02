# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::Base do
  it 'raise NotImplementedError' do
    expect { described_class.call }
      .to raise_error(NotImplementedError, 'Not implemented yet')
  end
end
