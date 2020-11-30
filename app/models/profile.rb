class Profile < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :rate, presence: true
  acts_as_taggable_on :skills
end
