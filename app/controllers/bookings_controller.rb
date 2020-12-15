class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @user = current_user
    @booking.user = @user
    @profile_skill = ProfileSkill.find(params[:booking][:profile_skill])
    @booking.profile_skill = @profile_skill
    if @booking.save
      attach_session_id
      flash[:notice] = "Your booking request has been sent"
      redirect_to new_booking_payment_path(@booking)
    else
      @profile = @profile_skill.profile
      render "profiles/show"
    end
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(update_booking_params)
      flash[:notice] = "Booking has been #{@booking.status}"
      redirect_to dashboard_path
    else
      render "pages/dashboard"
    end
  end

private
  def update_booking_params
    params.require(:booking).permit(:status)
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def attach_session_id
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @booking.profile_skill.skill.name,
        images: [@booking.profile.image],
        amount: @booking.amount_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: dashboard_url,
      cancel_url: dashboard_url
    )

    @booking.update(checkout_session_id: session.id)
  end

end

