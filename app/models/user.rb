# frozen_string_literal: true

class User < ApplicationRecord
  validates :full_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :password_digest, length: { maximum: 255 }
end
