class FreelancerReviewsController < ApplicationController
  def new
    @freelancer_review = FreelancerReview.new
    @booking = Booking.find(params[:booking_id])
  end

  def create
    @freelancer_review = FreelancerReview.new(freelancer_review_params)
    @booking = Booking.find(params[:booking_id])
    @freelancer_review.booking = @booking
    @freelancer_review.save!
    redirect_to dashboard_path
  end


  private

  def freelancer_review_params
    params.require(:freelancer_review).permit(:rating, :content)
  end
end

