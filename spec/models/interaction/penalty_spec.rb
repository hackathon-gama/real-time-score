# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Penalty, type: :model do
  let(:interaction) { create(:interaction_penalty) }

  describe '#update_match' do
    it 'set updated_at in match' do
      expect { interaction.update_match }
        .to change(interaction.match, :updated_at)
    end
  end
end
