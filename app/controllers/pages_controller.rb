class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def saved
  end


  def dashboard
    @bookings = current_user.bookings.order(:start_date)
    update_bookings(@bookings)
    
    
    @my_bookings = Booking.where(profile: current_user.profile).order(:start_date)
    @freelancer_bookings = Booking.joins(profile_skill: :profile).where(profiles: {user_id: current_user.id}).where.not(status: "rejected").order(:start_date)
      @bookings = @bookings.where(status: params[:status]) if params[:status].present?
      @freelancer_bookings = @freelancer_bookings.where(status: params[:status]) if params[:status].present?

  end

  private

  def update_bookings(bookings)
    @bookings.each do |booking|
      if booking.end_date < Time.now
        booking.status = "completed"
        booking.save
      end
    end
  end
end
