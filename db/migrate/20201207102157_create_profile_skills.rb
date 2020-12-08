class CreateProfileSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_skills do |t|

      t.timestamps
    end
  end
end
