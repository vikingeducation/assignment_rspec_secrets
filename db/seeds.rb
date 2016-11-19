# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Cleaning Database'
Secret.delete_all
User.delete_all


puts 'Creating Users'
10.times do |i|
  User.create!( :name => "foo#{i}",
                :email => "foo#{i}@bar.com",
                :password => "foobar",
                :password_confirmation => "foobar" )
end
users = User.all


puts 'Creating Secrets'
40.times do |i|
  Secret.create(  :title => "Baz Secret #{i}",
                  :body => "You won't believe what #{users.sample.name} did!",
                  :author => users.sample)
end


puts 'Done.'
