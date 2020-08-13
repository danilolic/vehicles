# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :model
  belongs_to :brand

  validates :fuel, presence: true
  validates :year_model, presence: true
  validates :value, presence: true

  # You can't delegate with #model_name because #model_name is a reserved method of rails
  delegate :name_of_model, to: :model
  delegate :name, to: :brand, prefix: true

  before_validation do |vehicle|
    vehicle.brand = vehicle.model.brand
  end
end
