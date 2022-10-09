# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stage, type: :model do
  subject(:stage) { build(:stage) }

  let(:enum_values) { { groups: 0, octave: 1, fourth_final: 2, semi:3, final: 4 } }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to define_enum_for(:name).with_values(enum_values) }
  end

  describe 'stage create' do
    before { stage.save }

    it { is_expected.to be_persisted }
  end
end
