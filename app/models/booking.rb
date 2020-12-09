class Booking < ApplicationRecord
  belongs_to :profile_skill
  belongs_to :user
  has_one :freelancer_review
  has_one :user_review
  validates :start_date, :end_date, presence: true #:start_time, :end_time,
  validate :check_booking_dates

  validate :end_date_after_start_date

  def total_price
    (end_date - start_date).to_i * profile_skill.rate
  end

  def booking_summary
    period = end_date - start_date
    period * profile_skill.rate
  end

  def profile
    profile_skill.profile
  end

  private

  def check_booking_dates
    errors.add(:availability, "Booking clash") unless profile_skill.profile.available_on?(start_date, end_date)
  end

  def end_date_after_start_date
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
