class AddReservationIdToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :reservation_id, :integer
  end
end
