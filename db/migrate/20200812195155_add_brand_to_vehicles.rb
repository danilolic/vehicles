class AddBrandToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_reference :vehicles, :brand, null: false, foreign_key: true
  end
end
