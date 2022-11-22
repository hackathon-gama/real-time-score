# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InteractionsChannel, type: :channel do
  fdescribe '#subscribed' do
    context 'when send correct match' do
      let(:match) { create(:match) }
      let(:stream_from) { "match_#{match.id}_interactions" }

      it 'will be subscribe correctly' do
        subscribe match_id: match.id

        expect(subscription).to be_confirmed
      end

      it 'return empty interactions' do
        expect { subscribe match_id: match.id }
          .to have_broadcasted_to(stream_from).with([])
      end

      it 'return correct interactions' do
        interaction = create(:interaction_starter, match: match)

        result = [
          {
            id: interaction.id,
            description: interaction.description,
            time: interaction.time,
            minutes: interaction.minutes,
            type: 'start',
            match: MatchSerializer.new(match)
          }.as_json
        ]

        expect { subscribe match_id: match.id }
          .to have_broadcasted_to(stream_from)
          .with(result)
      end
    end

    context 'when send incorrect match' do
      it 'will be reject' do
        subscribe match_id: SecureRandom.uuid

        expect(subscription).to be_rejected
      end
    end
  end
end
