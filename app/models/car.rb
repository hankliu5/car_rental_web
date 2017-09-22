class Car < ApplicationRecord
  validates :plate, :make, :model, :rate, :style, :location, :status, presence: true
  validates :plate, uniqueness: { case_sensitive: false }

  validates :style,
    :inclusion  => { :in => [ 'SUV', 'Sedan', 'Coupe' ],
    :message    => "%{value} is not a valid car style." }

  validates :status,
      :inclusion  => { :in => [ 'Checked Out', 'Available', 'Reserved' ],
      :message    => "%{value} is not a valid car style." }



end
