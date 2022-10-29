# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_length_of(:full_name).is_at_most(255) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:password_digest).is_at_most(255) }
  end

  describe 'user create' do
    before { user.save }

    it { is_expected.to be_persisted }
  end
end
