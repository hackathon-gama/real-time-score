# frozen_string_literal: true

class Interaction < ApplicationRecord
  enum interaction_type: {
    faults: 'faults', goal: 'goal',
    corner_kick: 'corner_kick', penalty: 'penalty',
    start_game: 'start_game', final_game: 'final_game'
  }
  validates :interaction_type, presence: true
  validates :description, length: { maximum: 255 }
  validates :time, numericality: { only_integer: true }
  validates :minutes, numericality: { only_integer: true }
end
