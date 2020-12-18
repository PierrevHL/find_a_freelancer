class FreelancerReview < ApplicationRecord
  belongs_to :booking
  has_one :profile, through: :booking
  after_create :update_profile_rating

  def update_profile_rating
    reviews = self.profile.freelancer_reviews
    average = (reviews.pluck(:rating).sum.to_f / reviews.size).round(2)
    self.profile.update(rating: average)
  end
end
