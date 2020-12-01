class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    @booking.user = @user
    @profile = Profile.find(params[:profile_id])
    @booking.profile = @profile
    if @booking.save!
      flash[:notice] = "Your booking is confirmed"
      redirect_to profile_path(@profile)
    else
      render "profiles/show"
    end
  end

private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

