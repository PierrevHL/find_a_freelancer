class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :home

  def home
  end


  def dashboard
    @bookings = current_user.bookings
    # compare booking end date with todays date (once default status has been assigned)
    @my_bookings = Booking.where(profile: current_user.profile)
  end
end
