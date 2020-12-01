class ProfilesController < ApplicationController
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
    params.require(:profile).permit(:location, :skill, :rate, :description, :location_specific)
  end
end
