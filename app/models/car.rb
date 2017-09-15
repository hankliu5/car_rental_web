class Car < ApplicationRecord
  resourcify
  validates :plate, :make, :model, :rate, :style, :location, presence: true
end
