class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index
    search_query = params[:query]

    if params[:search]
      dates = params[:search][:starts_at].split("to").map(&:strip).map(&:to_date)
      @profiles = Profile.geocoded.select { |profile| profile.available_on?(dates[0], dates[1]) }
    elsif search_query
      @profiles = Profile.where("location ILIKE '%#{search_query}%'").geocoded
    else
      @profiles = Profile.geocoded
    end

    @markers = @profiles.map do |profile|
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

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :rate, :description, :location_specific, :image)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
