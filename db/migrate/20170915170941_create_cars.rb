class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :plate
      t.string :make
      t.string :model
      t.integer :rate
      t.string :style
      t.string :location
      t.boolean :checkout

      t.timestamps
    end
  end
end
