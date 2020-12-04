class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :edit, :update]
  before_action :set_profile, only: [:edit, :update, :show]

  def index
    search_query = params[:query]

    sql_query = "\
      users.first_name @@ :query \
      OR profiles.location @@ :query \
      OR users.last_name @@ :query \
      OR tags.name @@ :query \
    "
    @profiles = Profile.geocoded

    if params[:search].present?
      dates = params[:search][:starts_at].split("to").map(&:strip).map(&:to_date)
      @profiles = @profiles.select { |profile| profile.available_on?(dates[0], dates[1]) }
    elsif search_query.present?
      @profiles = @profiles.joins(:user, taggings: :tag).where(sql_query, query: "%#{params[:query]}%").distinct
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
    params.require(:profile).permit(:location, :rate, :description, :location_specific, :image, skill_list: [])
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
