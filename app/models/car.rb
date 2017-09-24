class Car < ApplicationRecord
    has_many :reservations
    validates :plate, :make, :model, :rate, :style, :location, presence: true
end
