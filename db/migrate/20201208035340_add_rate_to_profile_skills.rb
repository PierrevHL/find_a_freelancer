class AddRateToProfileSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :profile_skills, :rate, :integer
  end
end
