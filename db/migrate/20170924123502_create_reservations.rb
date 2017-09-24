class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :pick_up_time
      t.datetime :return_time
      t.integer :user_id
      t.integer :car_id

      t.timestamps
    end
  end
end
