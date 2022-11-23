# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

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

f = 1

40.times do
  puts "Creating flight #{f}"
  flight = Flight.new(
    departure: Faker::Nation.capital_city,
    arrival: Faker::Nation.capital_city,
    capacity: rand(2..10),
    user: User.where(pilot: true).sample,
    date: (Date.today + rand(100)),
    price: rand(500..10_000)
  )
  flight.save!
  f += 1
end

b = 1
80.times do
  puts "Creating booking #{b}"
  Booking.create(
    flight: Flight.all.sample,
    user: User.all.sample
  )
  b += 1
end

puts ">>>> Seed done. Please check it with 'rails console' command in terminal :-)"
