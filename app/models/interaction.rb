# frozen_string_literal: true

class Interaction < ApplicationRecord
  belongs_to :match

  validates :description, length: { maximum: 255 }
  validates :time, numericality: { only_integer: true }
  validates :minutes, numericality: { only_integer: true }

  def update_match
    raise(NotImplementedError, 'Must be implemented!')
  end
end
