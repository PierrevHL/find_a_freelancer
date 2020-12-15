class RemoveRateFromProfileSkills < ActiveRecord::Migration[6.0]
  def change
    remove_column :profile_skills, :rate, :integer
    add_monetize :profile_skills, :rate, currency: { present: false }
  end
end
