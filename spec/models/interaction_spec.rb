# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  subject(:interaction) { build(:interaction) }

  describe 'validations' do
    it { is_expected.to validate_length_of(:interaction_type).is_at_most(255) }
    it { is_expected.to validate_length_of(:description).is_at_most(255) }
    it { is_expected.to validate_numericality_of(:minutes) }
    it { is_expected.to validate_numericality_of(:time) }
  end

  describe 'interaction create' do
    before { interaction.save }

    it { is_expected.to be_persisted }
  end
end
