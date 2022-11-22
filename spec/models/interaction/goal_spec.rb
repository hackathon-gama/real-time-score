# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Goal, type: :model do
  let(:interaction) { create(:interaction_goal) }

  describe '#udpate_match' do
    before do
      interaction.match.start!
    end

    it 'increment Match#home_goals by 1' do
      interaction.update(team_id: interaction.match.team_home_id)

      expect { interaction.update_match }
        .to change { interaction.match.home_goals }.by(1)
    end

    it 'increment Match#away_goals by 1' do
      interaction.update(team_id: interaction.match.team_away_id)

      expect { interaction.update_match }
        .to change { interaction.match.away_goals }.by(1)
    end
  end
end
