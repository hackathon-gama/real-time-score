# frozen_string_literal: true

class Interaction < ApplicationRecord
  belongs_to :match

  validates :description, length: { maximum: 255 }
  validates :time, numericality: { only_integer: true }, inclusion: { in: 1..2 }
  validates :minutes, numericality: { only_integer: true, less_than: 60 }

  def update_match
    raise(NotImplementedError, 'Must be implemented!')
  end
end
