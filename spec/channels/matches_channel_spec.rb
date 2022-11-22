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

        expect { subscribe stage: match.stage.name }
          .to have_broadcasted_to(match.stage.name)
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
