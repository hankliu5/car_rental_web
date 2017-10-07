class AddDoneToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :done, :boolean, :default => false
  end
end
