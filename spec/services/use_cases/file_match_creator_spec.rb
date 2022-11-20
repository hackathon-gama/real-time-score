# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::FileMatchCreator do
  let(:team_home) { create(:team) }
  let(:team_away) { create(:team) }
  let(:attributes) { %w[away_goals home_goals match_date team_away team_home stage] }

  def file_extractor_return(stage = :groups)
    {
      away_goals: 0, home_goals: 0, match_date: Faker::Time,
      team_away: Faker::Team.name, team_home: Faker::Team.name, stage:
    }.as_json
  end

  context 'when pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield(file_extractor_return)
        .and_yield(file_extractor_return)
    end

    it 'will create teams' do
      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(Match, :count).by(2)
    end

    it 'not create duplicate matches' do
      dada = file_extractor_return
      allow(file_extractor).to receive(:execute)
        .and_yield(dada)
        .and_yield(dada)

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(Match, :count).by(1)
    end
  end

  context 'when pass empty or invalid permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }
    let(:attributes) { [] }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield(file_extractor_return)
    end

    it 'raise ActiveRecord::RecordInvalid error without required permited_attributes' do
      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'when pass invalid relationships' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    it 'raise ActiveRecord::RecordInvalid with invalid Stage' do
      allow(file_extractor).to receive(:execute)
        .and_yield(file_extractor_return.merge('stage' => nil))

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'raise ActiveRecord::RecordInvalid with invalid TeamHome' do
      allow(file_extractor).to receive(:execute)
        .and_yield(file_extractor_return.merge('team_home' => nil))

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'raise ActiveRecord::RecordInvalid with invalid TeamAway' do
      allow(file_extractor).to receive(:execute)
        .and_yield(file_extractor_return.merge('team_away' => nil))

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
