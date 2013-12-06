# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



(1..10).each do |i|
  User.new({:email => "user#{i}@emai.com"}).save!
end

(1..10).each do |i|
  ShortenedUrl.create_for_user_and_long_url!(User.find(i), "google#{i}.com")
end

100.times do |i|
  Visit.record_visit!(User.find(rand(1..10)), ShortenedUrl.find(rand(1..10)))
end
