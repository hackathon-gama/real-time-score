# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::FileUserCreator do
  context 'when pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ full_name: Faker::Name.name_with_middle,
            email: Faker::Internet.email, password_digest: Faker::Internet.password })
        .and_yield({ full_name: Faker::Name.name_with_middle,
            email: Faker::Internet.email, password_digest: Faker::Internet.password })
    end

    it 'will create teams' do
      attributes = %w[full_name email password_digest]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to change(User, :count).by(2)
    end
  end

  context 'when dont pass correct permited_attributes' do
    let(:file_extractor) { instance_double(BaseExtractor) }

    before do
      allow(file_extractor).to receive(:execute)
        .and_yield({ full_name: Faker::Name.name_with_middle,
          email: Faker::Internet.email, password_digest: Faker::Internet.password })
    end

    it 'raise ActiveRecord::RecordInvalid error without required permited_attributes' do
      attributes = %w[]

      expect { described_class.call(file_extractor, permited_attributes: attributes) }
        .to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
