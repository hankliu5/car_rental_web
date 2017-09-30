class Car < ApplicationRecord
  after_initialize :set_checkout_default
  has_many :reservations, dependent: :destroy
  validates :plate, presence: true, length: { is: 7 }, uniqueness: true
  validates_format_of :plate, :with => /\A[a-zA-Z0-9]+\z/, :message => "Only allows letters and numbers."
  validates :make, :model, :location, presence: true
  validates :rate, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :style, presence: true, inclusion: { in: %w(Coupe Sedan SUV), :message => "Invalid car style" }
  validates_format_of :location, :with => /\A[a-zA-Z]+\z/, :message => "Only allows letters."

  def plate=(val)
    write_attribute :plate, val.upcase
  end

  def self.search(term, category)
    term.to_s.downcase!
    if term && category
      if category == 'Status'
        cars = [] # array
        Car.all.each do |car|
          case term
          when 'available'
            if car.reservation_time.nil? || (car.reservation_time.to_i < Time.now.to_i) && !car.checkout
              cars << car
            end
          when 'reserved'
            if (car.reservation_time.to_i > Time.now.to_i) && !car.checkout
              cars << car
            end
          when 'checked out'
            cars << car if car.checkout
          end
        end
        return cars
      else
        where("#{category} LIKE ?", "%#{term}%")
      end
    else
      all
    end
  end

  def set_checkout_default
    self.checkout = false
  end
end
