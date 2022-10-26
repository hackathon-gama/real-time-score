# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false }, if: -> { name_changed? }
  validates :description, presence: true, length: { maximum: 255 }
  has_one_attached :photo
end
