class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :home

  def home
  end


  def dashboard
    @bookings = current_user.bookings
    @bookings.each do |booking|
      if booking.end_date < Time.now
        booking.status = "completed"
      end
    end
    @my_bookings = Booking.where(profile: current_user.profile)
  end
end
