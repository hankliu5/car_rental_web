class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :plate, presence: true, length: { is: 7}, uniqueness: true
  validates_format_of :plate, :with => /[a-zA-Z\d]/, :message => "Only allows letters and numbers."

  validates :make, :model, :location, presence: true
  validates :rate, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :style, presence: true, inclusion: { in: %w(Coupe Sedan SUV), :message => "%{style} is invalid car style"}

  # validates :plate, uniqueness: { case_sensitive: false }
  #
  # validates :style,
  #   :inclusion  => { :in => [ 'SUV', 'Sedan', 'Coupe' ],
  #   :message    => "%{value} is not a valid car style." }
  #
  # validates :status,
  #     :inclusion  => { :in => [ 'Checked Out', 'Available', 'Reserved' ],
  #     :message    => "%{value} is not a valid car style." }
  def self.search(condition, search)
    if condition && search
        where(["#{condition} LIKE ?", "%#{search}%"])
    else
        all
    end
  end

end
