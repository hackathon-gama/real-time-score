# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  subject(:interaction) { build(:interaction) }

  describe 'validations' do
    it { is_expected.to validate_length_of(:description).is_at_most(255) }
    it { is_expected.to validate_numericality_of(:minutes).is_less_than(60) }
    it { is_expected.to validate_numericality_of(:time) }
    it { is_expected.to validate_inclusion_of(:time).in_range(1..2) }
    it { is_expected.to belong_to(:match) }
  end

  describe 'interaction create' do
    before { interaction.save }

    it { is_expected.to be_persisted }
  end

  describe '#udpate_match' do
    it 'raise NotImplementedError' do
      expect { interaction.update_match }
        .to raise_error(NotImplementedError, 'Must be implemented!')
    end
  end
end
