class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reservations
  validates :username, presence: true
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validates :password,
            # you only need presence on create
            presence: { on: :create },
            # allow_nil for length (presence will handle it on create)
            length: { minimum: 6, allow_nil: true },
            # and use confirmation to ensure they always match
            confirmation: true

  validates :password_confirmation, presence: true, if: '!password.nil?'
end
