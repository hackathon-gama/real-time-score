# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::FileStageCreator do
  context 'when pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ name: 'semi' })
        .and_yield({ name: 'semi' })
    end

    it 'will create stages' do
      attributes = %w[name]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(Stage, :count).by(2)
    end

    it 'will not set unspecified permited_attributes' do
      attributes = %w[]

      described_class.call(file_extractor, permited_attributes: attributes)

      expect(Stage.count).to eq(2)
    end
  end
end
