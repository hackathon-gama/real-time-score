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

  describe '#increment_goals!' do
    define_negated_matcher :not_change, :change
    before { match.save }

    it 'increment home goals' do
      expect { match.increment_goals!(team_id: match.team_home_id) }
        .to change(match, :home_goals).by(1)
    end

    it 'increment away goals' do
      expect { match.increment_goals!(team_id: match.team_away_id) }
        .to change(match, :away_goals).by(1)
    end

    it 'not change goals' do
      expect { match.increment_goals!(team_id: SecureRandom.uuid) }
        .to not_change(match, :home_goals)
        .and not_change(match, :away_goals)
    end
  end
end
