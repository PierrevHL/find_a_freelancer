class RemoveProfileIdFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :profile_id, :string
  end
end
