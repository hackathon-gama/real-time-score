# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  subject(:match) { build(:match) }

  describe 'associations' do
    it { is_expected.to belong_to(:stage) }
    it { is_expected.to belong_to(:team_away) }
    it { is_expected.to belong_to(:team_home) }
    it { is_expected.to have_many(:interactions) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:status).is_at_most(255) }
    it { is_expected.to validate_numericality_of(:home_goals) }
    it { is_expected.to validate_numericality_of(:away_goals) }
  end

  describe 'match create' do
    before { match.save }

    it { is_expected.to be_persisted }
  end
end
