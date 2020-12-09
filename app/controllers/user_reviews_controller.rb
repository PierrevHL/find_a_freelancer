class UserReviewsController < ApplicationController
  def new
    @user_review = UserReview.new
  end

  def create
    if @user_review.booking.status == "completed"
      @user_review = UserReview.new(user_review_params)
    end
  end


  private

  def user_review_params
    params.require(:user_review).permit(:rating, :content)
  end
end
