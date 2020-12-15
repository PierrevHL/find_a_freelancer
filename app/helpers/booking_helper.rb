module BookingHelper
  def client_message(booking)
    "Hey #{booking.user.first_name}! Here is #{booking.profile.user.first_name}. Thanks for choosing me as your #{booking.profile_skill.skill.name}! If you have any questions please don't hesitate to contact me anytime! :)"
  end

  def freelancer_message(booking)
    "Hey #{booking.profile.user.first_name}! Here is #{booking.user.first_name} and I need your help as #{booking.profile_skill.skill.name} please :)"
  end
end