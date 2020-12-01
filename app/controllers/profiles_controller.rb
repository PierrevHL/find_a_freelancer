class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    @booking = Booking.new
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @user = current_user
    @profile.user = @user
    @profile.save
    redirect_to profile_path(@profile)
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :rate, :description, :location_specific, :image)
  end
end
