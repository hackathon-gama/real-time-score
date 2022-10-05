# frozen_string_literal: true

class Team < ApplicationRecord

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :photo, length: { maximum: 255 }
end
