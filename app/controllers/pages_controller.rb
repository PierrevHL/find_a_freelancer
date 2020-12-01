class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def home
  end

  def dashboard
    @bookings = current_user.bookings
    @my_bookings = Booking.where(profile: current_user.profile)
  end
end
