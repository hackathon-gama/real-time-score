# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stage, type: :model do
  subject(:stage) { build(:stage) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it do
        should define_enum_for(:name).
          with_values(
            groups: 'groups',
            octave: 'octave',
            fourth_final: 'fourth_final',
            semi: 'semi',
            final: 'final'
          ).
          backed_by_column_of_type(:string)
      end
  end

  describe 'stage create' do
    before { stage.save }

    it { is_expected.to be_persisted }
  end
end
