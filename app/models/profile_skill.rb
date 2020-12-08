class ProfileSkill < ApplicationRecord
  belongs_to :profile
  belongs_to :skill
  has_many :bookings
end
