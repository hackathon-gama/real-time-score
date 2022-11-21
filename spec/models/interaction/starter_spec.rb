# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Starter, type: :model do
  subject(:interaction) { create(:interaction_starter) }

  describe '#udpate_match' do
    it 'change Match#status from pending to running' do
      expect { interaction.update_match }
        .to change { interaction.match.status }
        .from('pending').to('running')
    end
  end
end
