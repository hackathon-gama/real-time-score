# frozen_string_literal: true

class Interaction < ApplicationRecord
  validates :interaction_type, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
  validates :time, numericality: { only_integer: true }
  validates :minutes, numericality: { only_integer: true }
end
