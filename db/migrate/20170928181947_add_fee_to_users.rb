class AddFeeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fee, :integer
  end
end
