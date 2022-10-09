# frozen_string_literal: true

class Team < ApplicationRecord

  validates :name, uniqueness: true, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :photo, presence: true
end
