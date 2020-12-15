class ProfileSkill < ApplicationRecord
  belongs_to :profile
  belongs_to :skill
  has_many :bookings
  validates :skill, uniqueness: { scope: :profile}
  monetize :rate_cents
end
