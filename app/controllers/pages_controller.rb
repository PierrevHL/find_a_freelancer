class PagesController < ApplicationController
  def home
  end

  def dashboard
    @bookings = current_user.bookings
    @my_bookings = Booking.where(profile: current_user.profile)
  end
end
