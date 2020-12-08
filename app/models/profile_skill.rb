class ProfileSkill < ApplicationRecord
  belongs_to :profile
  validates :rate, presence: true
end
