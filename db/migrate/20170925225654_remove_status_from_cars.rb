class RemoveStatusFromCars < ActiveRecord::Migration[5.1]
  def change
    remove_column :cars, :status, :string
  end
end
