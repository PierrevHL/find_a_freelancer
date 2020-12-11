class AddRatingToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :rating, :float
  end
end
