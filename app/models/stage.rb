# frozen_string_literal: true

class Stage < ApplicationRecord
  validates :name, presence: true

  enum name: {
    groups: 'groups', octave: 'octave',
    fourth_final: 'fourth_final', semi: 'semi', final: 'final'
  }
end
