# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Destroying old data'
if ['development', 'test'].include?(Rails.env)
  Rake::Task['db:migrate:reset'].invoke
end

puts 'Creating users'
10.times do |i|
  User.create!( :name => "foo#{i}", 
                :email => "foo#{i}@bar.com", 
                :password => "password", 
                :password_confirmation => "password" )
end

users = User.all
40.times do |i|
  Secret.create(  :title => "Baz Secret #{i}",
                  :body => "You won't believe what #{users.sample.name} did!",
                  :author => users.sample)
end

puts 'done!'