class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    @booking.user = @user
    @profile_skill = ProfileSkill.find(params[:booking][:profile_skill])
    @booking.profile_skill = @profile_skill
    if @booking.save
      flash[:notice] = "Your booking request has been sent"
      redirect_to profile_path(@profile_skill.profile)
    else
      @profile = @profile_skill.profile
      render "profiles/show"
    end
  end

  def update
    @booking = Booking.find(params[:id])
    
    if @booking.update(update_booking_params)
      flash[:notice] = "Booking has been #{@booking.status}"
      redirect_to dashboard_path
    else
      render "pages/dashboard"
    end
  end

private
  def update_booking_params
    params.require(:booking).permit(:status)
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

