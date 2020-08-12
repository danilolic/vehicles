class Vehicle < ApplicationRecord
  belongs_to :model

  validates :fuel, presence: true
  validates :year_model, presence: true
  validates :value, presence: true
end
