# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :stage
  belongs_to :team_home, class_name: 'Team'
  belongs_to :team_away, class_name: 'Team'

  validates :home_goals, numericality: { only_integer: true }
  validates :away_goals, numericality: { only_integer: true }
  validates :status, length: { maximum: 255 }
end
