class Vehicle < ApplicationRecord
  belongs_to :model
  belongs_to :brand

  validates :fuel, presence: true
  validates :year_model, presence: true
  validates :value, presence: true

  delegate :name, to: :brand, prefix: true
  delegate :name_of_model, to: :model
end
