# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :models, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
