class Car < ApplicationRecord
    validates :plate, :make, :model, :rate, :style, :location, presence: true
end
