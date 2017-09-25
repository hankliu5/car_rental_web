class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :pick_up_time, :return_time, :user_id, :car_id, presence: true
end
