class ProfilesController < ApplicationController
  def index
    search_query = params[:query]
    if search_query
      @profiles = Profile.where("location ILIKE '%#{search_query}%'")
    else
      @profiles = Profile.all
    end
    @markers = @profiles.geocoded.map do |profile|
      {
        lat: profile.latitude,
        lng: profile.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { profile: profile })
      }
    end
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
    if @profile.save
      params[:profile][:skills][1..-1].each do |skill|
        @profile.skill_list.add(skill)
      end
      @profile.save
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :rate, :description, :location_specific, :image)
  end
end
