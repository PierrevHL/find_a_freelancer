class Booking < ApplicationRecord
  belongs_to :profile_skill
  has_one :profile, through: :profile_skill
  belongs_to :user
  has_one :freelancer_review
  has_one :user_review
  validates :start_date, :end_date, presence: true #:start_time, :end_time,
  validate :check_booking_dates, on: :create
  monetize :amount_cents

  before_create :set_amount

  validate :end_date_after_start_date

  def total_price
    ((end_date - start_date).to_i + 1) * profile_skill.rate * 8
  end

  def booking_summary
    period = end_date - start_date
    period * profile_skill.rate
  end

  def profile
    profile_skill.profile
  end

  def set_amount
    self.amount = self.total_price
  end

  private

  def check_booking_dates
    return if !profile_skill
    errors.add(:availability, "Booking clash") unless profile_skill.profile.available_on?(start_date, end_date)
  end

  def end_date_after_start_date
   return if !end_date || !start_date

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
