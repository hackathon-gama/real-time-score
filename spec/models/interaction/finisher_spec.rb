# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction::Finisher, type: :model do
  subject(:interaction) { create(:interaction_finisher) }

  fdescribe '#udpate_match' do
    it 'should change Match#status from pending to running' do
      subject.match.start!

      expect { subject.update_match }
        .to change { subject.match.status }
        .from('running').to('finished')
    end
  end
end
