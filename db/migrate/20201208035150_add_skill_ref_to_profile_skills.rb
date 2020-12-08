class AddSkillRefToProfileSkills < ActiveRecord::Migration[6.0]
  def change
    add_reference :profile_skills, :skill, null: false, foreign_key: true
  end
end
