class Car < ApplicationRecord
  after_initialize :set_checkout_default
  has_many :reservations, dependent: :destroy
  validates :plate, presence: true, length: { is: 7 }, uniqueness: true
  validates_format_of :plate, with: /\A[a-zA-Z0-9]+\z/, message: 'Only allows letters and numbers.'
  validates :make, :model, :location, presence: true
  validates :rate, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :style, presence: true, inclusion: { in: %w[Coupe Sedan SUV], message: 'Invalid car style' }
  validates_format_of :location, with: /\A[a-zA-Z]+\z/, message: 'Only allows letters.'

  def plate=(val)
    write_attribute :plate, val.upcase
  end

  def self.search(term, category)
    if term && category
      if category == 'Status'
        cars = [] # array
        Car.all.each do |car|
          case term
          when 'available'
            cars << car if car.reservation_time.nil? || (car.reservation_time.to_i < Time.now.to_i) && !car.checkout
          when 'reserved'
            cars << car if (car.reservation_time.to_i > Time.now.to_i) && !car.checkout
          when 'checked out'
            cars << car if car.checkout
          end
        end
        cars
      else
        if Rails.env.to_sym != :production
          where("#{category} LIKE ?", "%#{term}%")
        else
          where("#{category} ILIKE ?", "%#{term}%")
        end
      end
    end
  end

  def set_checkout_default
    self.checkout = false
  end
end
