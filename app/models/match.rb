# frozen_string_literal: true

class Match < ApplicationRecord
  include AASM

  belongs_to :stage
  belongs_to :team_home, class_name: 'Team'
  belongs_to :team_away, class_name: 'Team'

  has_many :interactions, dependent: :destroy

  validates :home_goals, numericality: { only_integer: true }
  validates :away_goals, numericality: { only_integer: true }
  validates :status, length: { maximum: 255 }
  validates :stage, uniqueness: { scope: %i[team_home_id team_away_id] }

  aasm column: :status, requires_lock: true do
    state :pending, initial: true
    state :running, :finished

    event :start do
      transitions from: :pending, to: :running
    end

    event :done do
      transitions from: :running, to: :finished
    end
  end
end
