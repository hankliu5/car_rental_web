class AddReservationTimeToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :reservation_time, :datetime
  end
end
