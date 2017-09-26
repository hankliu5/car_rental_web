class AddCheckoutToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :checkout, :boolean
  end
end
