# frozen_string_literal: true

class Model < ApplicationRecord
  belongs_to :brand

  validates :name, presence: true, uniqueness: true
end
