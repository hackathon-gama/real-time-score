# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileImportTeamJob, type: :job do
  describe '#perform' do
    context 'when have valid file' do
      let(:file_import_manager) do
        create(:file_import_manager, file: fixture_file_upload('csv_with_semicolon.csv'))
      end

      it 'create correct number of teams' do
        expect { described_class.perform_now(file_import_manager.id) }
          .to change(Team, :count).by(3)
      end
    end

    context 'when have invalid file' do
      let(:file_import_manager) do
        create(:file_import_manager, file: fixture_file_upload('photo.png'))
      end

      it 'raise TypeError with invalid extension' do
        expect { described_class.perform_now(file_import_manager.id) }
          .to raise_error(TypeError, 'file extension must be in: (csv)')
      end

      it 'raise TypeError without file' do
        file_import_manager.update(file: nil)

        expect { described_class.perform_now(file_import_manager.id) }
          .to raise_error(TypeError, 'file extension must be in: (csv)')
      end
    end
  end
end
