# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Finisher, type: :model do
  subject(:interaction) { create(:interaction_finisher) }

  describe '#udpate_match' do
    it 'change Match#status from running to finished' do
      interaction.match.start!

      expect { interaction.update_match }
        .to change { interaction.match.status }
        .from('running').to('finished')
    end
  end
end
