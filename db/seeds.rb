# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

puts "Cleaning database"

Booking.destroy_all
Profile.destroy_all
User.destroy_all

puts "Database claned"
skill = ["Photographer", "Programmer", "UX Designer", "Cleaner", "Plumber", "Electrical technician", "Tutor", "Translator", "Driver", "Gardener", "Model"]

skill.each {|skill| Skill.create(name: skill)}

20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123",
  )
  puts "#{User.count} users created"
end

User.first(4).each do |user|
  user.freelancer = true
  user.save!
  profile = Profile.create!(
    location: Faker::Nation.capital_city,
    description: Faker::Quote.famous_last_words,
    user_id: user.id
  )

  keyword = ["worker", "person", "businessman"].sample
  file = URI.open("https://source.unsplash.com/800x600/?#{keyword}")
  profile.image.attach(io: file, filename: "#{profile.user.first_name}.jpg", content_type: 'image/png')

  rand(1..5).times do
    ProfileSkill.create(profile_id: profile.id, skill: Skill.all.sample, rate: rand(50..100))
  end
  puts "#{Profile.count} profiles created"
end

Profile.first(10).each do |profile|
  profile.location_specific = true
  profile.save!
end

5.times do
  start =  Date.today + rand(30..40)
  Booking.create(
    start_date: start,
    end_date: start + rand(2..3),
    user: User.all.sample,
    profile_skill: ProfileSkill.all.sample,
  )
  puts "#{Booking.count} bookings created"
end

puts "Finished seeding"
