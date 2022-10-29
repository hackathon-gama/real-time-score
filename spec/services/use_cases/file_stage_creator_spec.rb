# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::FileStageCreator do
  context 'when pass correct permited_attributes' do
    byebug
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ name: 'semi' })
        .and_yield({ name: 'semi' })
    end

    it 'will create stages' do
      attributes = %w[name]
      byebug
      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(Stage, :count).by(2)
    end

    it 'will not set unspecified permited_attributes' do
      attributes = %w[name]

      described_class.call(file_extractor, permited_attributes: attributes)

      expect(Stage.last.name).to be_nil
    end
  end

  context 'when dont pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ name: 'semi' })
    end

    it 'raise ActiveRecord::RecordInvalid error without required permited_attributes' do
      attributes = %w[]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
