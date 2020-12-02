class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_one :profile
  has_many :conversations
  validates :email, presence: true

  def capitalized_user
    first_name.capitalize
    last_name.capitalize
  end
end
