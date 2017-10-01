class AddReservationIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reservation_id, :integer
  end
end
