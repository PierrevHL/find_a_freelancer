class Booking < ApplicationRecord
  belongs_to :profile_skill
  belongs_to :user
  validates :start_date, :end_date, :start_time, :end_time, presence: true
  validate :check_booking_dates

  validate :end_date_after_start_date

  def total_price
    (end_date - start_date).to_i * profile_skills.rate
  end

  def booking_summary
    period = end_date - start_date
    period * profile_skills.rate
  end
  private

  def check_booking_dates
    errors.add(:availability, "Booking clash") unless profile.available_on?(start_date, end_date)
  end

  def end_date_after_start_date
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

end
