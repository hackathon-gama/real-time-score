# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Starter, type: :model do
  subject(:interaction) { create(:interaction_starter) }

  describe '#udpate_match' do
    it 'should change Match#status from pending to running' do
      expect { subject.update_match }
        .to change { subject.match.status }
        .from('pending').to('running')
    end
  end
end
