class RemoveCheckoutFromCars < ActiveRecord::Migration[5.1]
  def change
    remove_column :cars, :checkout, :boolean
  end
end
