# frozen_string_literal: true

class Model < ApplicationRecord
  has_many :vehicles
  belongs_to :brand

  validates :name, presence: true, uniqueness: true

  def name_of_model
    name
  end
end
