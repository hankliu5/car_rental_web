class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :plate, :make, :model, :rate, :style, :location, presence: true
end
