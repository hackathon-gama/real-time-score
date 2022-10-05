# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stage, type: :model do
  subject(:stage) { build(:stage) }

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
  end

  describe 'stage create' do
    before { stage.save }

    it { is_expected.to be_persisted }
  end
end
