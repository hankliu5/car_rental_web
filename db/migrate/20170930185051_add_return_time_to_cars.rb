class AddReturnTimeToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :return_time, :datetime
  end
end
