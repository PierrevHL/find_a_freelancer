class AddProfileSkillIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :profile_skill, null: false, foreign_key: true
  end
end
