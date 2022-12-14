# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

################################################################################
#### GEMS & CONFIG
require 'faker'
require "open-uri"
require 'date'

################################################################################
#### CREATING 100 USERS

u = 1
100.times do
  puts "Creating user #{u}"
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: Faker::Internet.password(min_length: 8),
    pilot: Faker::Boolean.boolean(true_ratio: 0.5)
  )
  user.email = Faker::Internet.email(name: "#{user.first_name} #{user.last_name}", separators: ".")
  user.save!
  u += 1
end

# ################################################################################
# #### CREATING 60 FLIGHTS RANDOMLY

f = 1
60.times do
  puts "Creating flight #{f}"
  flight = Flight.new(
    departure: Faker::Nation.capital_city,
    arrival: Faker::Nation.capital_city,
    capacity: rand(2..10),
    user: User.where(pilot: true).sample,
    date: (DateTime.now + rand(100)),
    price: rand(500..10_000)
  )
  flight.save!
  f += 1
end

# ################################################################################
# #### CREATING 160 BOOKINGS BASED ON FLIGHTS & USERS

b = 1
160.times do
  puts "Creating booking #{b}"
  Booking.create(
    flight: Flight.all.sample,
    user: User.all.sample
  )
  b += 1
end

# ################################################################################
# #### ADDING PROFILE PICS TO USERS THAT DON'T HAVE ONE ALREADY

User.all.each do |user|
  if user.photo.attached?
    puts "> #{user.first_name} #{user.last_name} already has a profile picture attached >>> no picture added"
  else
    file = URI.open("https://api.lorem.space/image/face?w=200&h=200")
    # article = Article.new(title: "NES", body: "A great console")
    user.photo.attach(io: file, filename: "#{user.first_name}_#{user.last_name}.png", content_type: "image/png")
    user.save!
    puts "> #{user.first_name} #{user.last_name} photo attached >>> #{user.photo.attached?}"
  end
end

# ################################################################################
# #### ADDING PHOTOS TO FLIGHTS

Flight.all.each do |flight|
  if flight.photo.attached?
    puts "> #{flight.departure} >> #{flight.arrival} already has a profile picture attached >>> no picture added"
  else
    file = File.open("app/assets/images/flights/flight_#{flight.id}.jpg")
    # article = Article.new(title: "NES", body: "A great console")
    flight.photo.attach(
      io: file,
      filename: "#{flight.departure}_#{flight.arrival}_#{flight.id}.png",
      content_type: "image/png"
    )
    flight.save!
    puts "> #{flight.departure} #{flight.arrival} photo attached >>> #{flight.photo.attached?}"
  end
end

# ################################################################################
# #### UPDATE EACH FLIGHT FOR GEOCODING //// USELESS

# Flight.all.each do |flight|
#   flight.save!
# end


puts ">>>> Seed done. Please check it with 'rails console' command in terminal :-)"
