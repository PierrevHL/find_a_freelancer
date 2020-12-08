class Profile < ApplicationRecord
  SKILLS = ["Photographer", "Programmer", "UX Designer", "Cleaner", "Plumber", "Electrical technician", "Tutor", "Translator", "Driver", "Gardener", "Model"]
  belongs_to :user
  has_many :profile_skills
  has_one_attached :image
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def available_on?(start_date, end_date)
    bookings.where("(? >= start_date AND ? <= end_date) OR (? >= start_date AND ? <= end_date)", start_date, end_date, start_date, end_date).empty?
  end

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

end
