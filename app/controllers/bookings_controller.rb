class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    @booking.user = @user
    @profile_skill = ProfileSkill.find(params[:profile_skill_id])
    @booking.profile_skill = @profile_skill
    if @booking.save
      flash[:notice] = "Your booking is confirmed"
      redirect_to profile_path(@profile)
    else
      render "profiles/show"
    end
  end

private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :start_time, :end_time)
  end
end

