class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :edit, :update]
  before_action :set_profile, only: [:edit, :update, :show, :edit_rates, :add_favorite, :unfavorite]

  def index
    search_query = params[:query]
    skill_query = params[:skill]
    low_rate_query = params[:low_rate]
    high_rate_query = params[:high_rate]
    sql_full_query = "\
      users.first_name @@ :query \
      OR profiles.location @@ :query \
      OR users.last_name @@ :query"
    sql_skill_query = "skills.name @@ :skill"
    @profiles = Profile.all

    if search_query.present?
      @profiles = Profile.joins(:user).where(sql_full_query, query: "%#{params[:query]}%").distinct
    end
    if skill_query.present?
      @profiles = @profiles.joins(profile_skills: :skill).where(sql_skill_query, skill: "%#{params[:skill]}%").distinct
    end
    if low_rate_query.present? || high_rate_query.present?
      low_rate = low_rate_query.present? ? low_rate_query.to_i : 0
      high_rate = high_rate_query.present? ? high_rate_query.to_i : 1000000
      @profiles = @profiles.joins(:profile_skills).where(profile_skills: {rate: low_rate..high_rate}).distinct
    end

    if params[:search].present? && params[:search][:starts_at].present?
      dates = [params[:search][:starts_at], params[:search][:ends_at]].map(&:strip).map(&:to_date)
      @profiles = @profiles.select { |profile| profile.available_on?(dates[0], dates[1]) }
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
        ProfileSkill.create!(profile: @profile, skill_id: skill)
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
      params[:profile][:skills][1..-1].each do |skill|
        ProfileSkill.create!(profile: @profile, skill_id: skill)
      end
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  def edit_rates
  end

  def add_favorite
    current_user.favorite(@profile)
    redirect_to profile_path(@profile)
  end

  def unfavorite
    current_user.unfavorite(@profile)
    redirect_to profile_path(@profile)
  end

  private

  def profile_params
    params.require(:profile).permit(:location, :description, :location_specific, :image)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
