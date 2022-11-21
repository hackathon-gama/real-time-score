# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatchesChannel, type: :channel do
  describe '#subscribed' do
    context 'when send correct stage name' do
      let(:stage) { create(:stage) }

      it 'will be subscribe correctly' do
        subscribe stage: stage.name

        expect(subscription).to be_confirmed
      end

      it 'return empty matches' do
        expect { subscribe stage: stage.name }
          .to have_broadcasted_to(stage.name).with([])
      end

      it 'return correct matches' do
        match = create(:match)
        result = [
          {
            id: match.id,
            team_home: match.team_home.name,
            team_away: match.team_away.name,
            stage: match.stage.name,
            home_goals: match.home_goals,
            away_goals: match.away_goals,
            status: match.status,
            match_date: match.match_date
          }.as_json
        ]

        expect { subscribe stage: match.stage.name }
          .to have_broadcasted_to(match.stage.name)
          .with(result)
      end
    end

    context 'when send incorrect stage name' do
      it 'will be reject' do
        subscribe stage: Faker::Lorem.sentence

        expect(subscription).to be_rejected
      end
    end
  end
end
