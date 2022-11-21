# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Fault, type: :model do
  let(:interaction) { create(:interaction_fault) }

  describe '#udpate_match' do
    it 'raise NotImplementedError' do
      expect { interaction.update_match }
        .to raise_error(NotImplementedError, 'Must be implemented!')
    end
  end
end
