class Profile < ApplicationRecord
  belongs_to :user
  has_many :profile_skills
  has_many :bookings, through: :profile_skills
  has_many :freelancer_reviews, through: :bookings
  has_many :skills, through: :profile_skills
  has_one_attached :image
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  after_create :update_user
  acts_as_favoritable

  def available_on?(start_date, end_date)
    bookings.where("(? >= start_date AND ? <= end_date) OR (? >= start_date AND ? <= end_date)", start_date, start_date, end_date, end_date).empty?
  end

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  def update_user
    self.user.update(freelancer: true)
  end

  def min_rate
    profile_skills.minimum(:rate_cents)
  end

  def max_rate
    profile_skills.maximum(:rate_cents)
  end
end
