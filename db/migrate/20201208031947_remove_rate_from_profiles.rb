class RemoveRateFromProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :rate
  end
end
