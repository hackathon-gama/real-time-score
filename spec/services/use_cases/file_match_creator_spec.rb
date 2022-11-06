# frozen_string_literal: true

require 'rails_helper'


  # away_goals { 1 }
  # status { 'running' }
  # match_date { '2022-10-11 23:22:10' }
  # stage
  # association :team_away, factory: :team
  # association :team_home, factory: :team

RSpec.describe UseCases::FileMatchCreator do
  context 'when pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }
    let!(:team_home) { create(:team) }
    let!(:team_away) { create(:team) }
    let!(:stage) { create(:stage) }
    let!(:stage2) { create(:stage) }

    before do
      byebug
      allow(file_extractor).to receive(:execute)
        .and_yield({ away_goals: 0, home_goals: 0, match_date: '2022-10-11 23:22:10', team_away: team_away, team_home: team_home, stage: stage  })
        .and_yield({ away_goals: 2, home_goals: 1, match_date: '2022-05-11 23:22:10', team_away: team_away, team_home: team_home, stage: stage2  })
    end

    it 'will create teams' do
      attributes = %w[away_goals home_goals match_date team_away team_home stage]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(Match, :count).by(2)
    end

    it 'will not set unspecified permited_attributes' do
      attributes = %w[name]

      described_class.call(file_extractor, permited_attributes: attributes)

      expect(Match.last.description).to be_nil
    end
  end

  # context 'when dont pass correct permited_attributes' do
  #   let(:file_extractor) { instance_double(BaseExtractor) }

  #   before do
  #     allow(file_extractor).to receive(:execute)
  #       .and_yield({ name: Faker::Team.name, description: Faker::Team.sport })
  #   end

  #   it 'raise ActiveRecord::RecordInvalid error without required permited_attributes' do
  #     attributes = %w[]

  #     expect { described_class.call(file_extractor, permited_attributes: attributes) }
  #       .to raise_error(ActiveRecord::RecordInvalid)
  #   end
  # end
end
