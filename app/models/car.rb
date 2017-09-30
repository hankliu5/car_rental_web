class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :plate, presence: true, length: { is: 7 }, format: { with: /[a-zA-Z0-9]/ }, uniqueness: true
  validates_format_of :plate, :with => /\A[a-zA-Z0-9]+\z/, :message => "Only allows letters and numbers."
  validates :make, :model, :location, presence: true
  validates :rate, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :style, presence: true, inclusion: { in: %w(Coupe Sedan SUV), :message => "%{style} is invalid car style"}

  # validates :location, presence: :true
  # validates_format_of :location, :with => /[a-zA-Z]/, :message => "Only allows letters."

  # validates :plate, uniqueness: { case_sensitive: false }
  #
  # validates :style,
  #   :inclusion  => { :in => [ 'SUV', 'Sedan', 'Coupe' ],
  #   :message    => "%{value} is not a valid car style." }
  #
  # validates :status,
  #     :inclusion  => { :in => [ 'Checked Out', 'Available', 'Reserved' ],
  #     :message    => "%{value} is not a valid car style." }
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
end
