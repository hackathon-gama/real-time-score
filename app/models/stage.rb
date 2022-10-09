# frozen_string_literal: true

class Stage < ApplicationRecord
  validates :name, presence: true

  enum name: { groups: 0, octave: 1, fourth_final: 2, semi:3, final: 4 }
end
