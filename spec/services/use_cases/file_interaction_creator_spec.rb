# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::FileInteractionCreator do
  let!(:match) { create(:match) }

  context 'when pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ interaction_type: 'start_game', description: Faker::Lorem.sentence,
          time: 1, minutes: 20, match: match })
        .and_yield({ interaction_type: 'faults', description: Faker::Lorem.sentence,
          time: 2, minutes: 20, match: match })
    end

    it 'will create teams' do
      attributes = %w[interaction_type description time minutes match]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(Interaction, :count).by(2)
    end
  end

  context 'when dont pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ interaction_type: 'start_game', description: Faker::Lorem.sentence,
          time: 1, minutes: 20, match: match })
        .and_yield({ interaction_type: 'faults', description: Faker::Lorem.sentence,
          time: 2, minutes: 20, match: match })
    end

    it 'raise ActiveRecord::RecordInvalid error without required permited_attributes' do
      attributes = %w[]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
