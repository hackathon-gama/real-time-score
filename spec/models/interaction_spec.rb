# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  subject(:interaction) { build(:interaction) }

  describe 'validations' do
    it { is_expected.to validate_length_of(:description).is_at_most(255) }
    it { is_expected.to validate_numericality_of(:minutes) }
    it { is_expected.to validate_numericality_of(:time) }

    it do
      expect(interaction).to define_enum_for(:interaction_type)
        .with_values(
          faults: 'faults', goal: 'goal',
          corner_kick: 'corner_kick', penalty: 'penalty',
          start_game: 'start_game', final_game: 'final_game'
        )
        .backed_by_column_of_type(:string)
    end
  end

  describe 'interaction create' do
    before { interaction.save }

    it { is_expected.to be_persisted }
  end
end
