class UserReviewsController < ApplicationController
  def new
    @user_review = UserReview.new
    @booking = Booking.find(params[:booking_id])
  end

  def create
    @user_review = UserReview.new(user_review_params)
    @booking = Booking.find(params[:booking_id])
    @user_review.booking = @booking
    @user_review.save!
    redirect_to dashboard_path
  end


  private

  def user_review_params
    params.require(:user_review).permit(:rating, :content)
  end
end
