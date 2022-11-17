# frozen_string_literal: true

class FileImportManager < ApplicationRecord
  include AASM

  has_one_attached :file

  validates :status, length: { maximum: 255 }
  validates :retries, numericality: { only_integer: true }

  aasm column: :status, requires_lock: true do
    state :pending, initial: true
    state :processing, :processed, :failed

    event :start do
      transitions from: :pending, to: :processing
    end

    event :done do
      transitions from: :processing, to: :processed
    end
  end

  def can_run?
    pending? || failed?
  end

  def file_extension
    file&.filename&.extension
  end
end
