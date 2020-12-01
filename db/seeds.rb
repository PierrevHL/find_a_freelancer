# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Profile.destroy_all
User.destroy_all

skill = ["Photographer", "Programmer", "UX Designer", "Cleaner", "Plumber", "Electrical technician", "Tutor", "Translator", "Driver", "Gardener", "Model"]

100.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123",
    username: Faker::Internet.username
  )
end

User.first(50).each do |user|
  user.freelancer = true
  profile = Profile.create!(
    location: Faker::Nation.capital_city,
    rate: rand(50..100),
    description: Faker::Quote.famous_last_words,
    user_id: user.id
  )
  profile.skill_list.add(skill.sample)
  profile.save!
end

Profile.first(20).each do |profile|
  profile.location_specific = true
  profile.save!
end
