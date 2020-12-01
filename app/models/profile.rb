class Profile < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :image
  validates :rate, presence: true
  acts_as_taggable_on :skills
end
