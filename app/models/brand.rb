# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :models
  validates :name, presence: true, uniqueness: true
end
