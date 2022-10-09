# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  subject(:team) { build(:team) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { is_expected.to validate_length_of(:description).is_at_most(255) }
  end

  describe 'team create' do
    before { team.save }

    it { is_expected.to be_persisted }
  end
end
