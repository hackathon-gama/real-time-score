# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileImportManager, type: :model do
  subject { file_import_manager }

  let(:file_import_manager) { build(:file_import_manager) }

  describe 'validations' do
    it { is_expected.to validate_length_of(:status).is_at_most(255) }
    it { is_expected.to validate_numericality_of(:retries) }
    it { is_expected.to have_one_attached(:file) }
  end

  describe 'aasm state machine' do
    context 'when status is pending' do
      it { is_expected.to have_state(:pending) }
      it { is_expected.to transition_from(:pending).to(:processing).on_event(:start) }

      it 'will return can_run? equal true' do
        expect(file_import_manager.can_run?).to be(true)
      end
    end

    context 'when status is processing' do
      subject(:file_import_manager) { build(:file_import_manager, status: :processing) }

      it { is_expected.to have_state(:processing) }
      it { is_expected.to transition_from(:processing).to(:processed).on_event(:done) }
      it { is_expected.to transition_from(:processing).to(:failed).on_event(:fail) }

      it 'will return can_run? equal true' do
        expect(file_import_manager.can_run?).to be(false)
      end
    end

    context 'when status is processed' do
      subject(:file_import_manager) { build(:file_import_manager, status: :processed) }

      it { is_expected.to have_state(:processed) }

      it 'will return can_run? equal true' do
        expect(file_import_manager.can_run?).to be(false)
      end
    end

    context 'when status is failed' do
      subject(:file_import_manager) { build(:file_import_manager, status: :failed) }

      it { is_expected.to have_state(:failed) }
      it { is_expected.to transition_from(:failed).to(:processing).on_event(:retry) }

      it 'will return can_run? equal true' do
        expect(file_import_manager.can_run?).to be(true)
      end
    end
  end

  describe 'file_import_manager create' do
    before { file_import_manager.save }

    it { is_expected.to be_persisted }
  end
end
