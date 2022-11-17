# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileImportTeamJob, type: :job do
  describe '#perform' do
    context 'when have valid file' do
      let(:file_import_manager) do
        file = fixture_file_upload('csv/teams/with_semicolon.csv')

        create(:file_import_manager, file: file)
      end

      context 'when FileImportTeam can run' do
        it 'create correct number of teams' do
          expect { described_class.perform_now(file_import_manager.id) }
            .to change(Team, :count).by(3)
        end

        it 'will change file_import_manager status from pending to processed' do
          expect { described_class.perform_now(file_import_manager.id) }
            .to change { file_import_manager.reload.status }
            .from('pending').to('processed')
        end

        context 'when have one team with invalid attributes' do
          let(:file_import_manager) do
            file = fixture_file_upload('csv/teams/with_invalid_team.csv')
            create(:file_import_manager, file: file)
          end

          it 'will raise ActiveRecord::RecordInvalid' do
            expect { described_class.perform_now(file_import_manager.id) }
              .to raise_error(ActiveRecord::RecordInvalid)
          end

          it 'will not create teams' do
            described_class.perform_now(file_import_manager.id)
          rescue ActiveRecord::RecordInvalid
            expect(Team.count).to eq(0)
          end
        end
      end

      context 'when FileImportTeam can not run' do
        before { file_import_manager.start! }

        it 'will not create teams' do
          expect { described_class.perform_now(file_import_manager.id) }
            .not_to change(Team, :count)
        end
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
