class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_one :profile
  has_one_attached :image
  has_many :conversations
  validates :email, presence: true
  validates :email, uniqueness: true
end
