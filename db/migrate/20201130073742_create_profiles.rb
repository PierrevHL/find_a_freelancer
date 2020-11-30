class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :location
      t.integer :rate
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.boolean :location_specific

      t.timestamps
    end
  end
end
