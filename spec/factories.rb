FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:name) {|n| "Foo#{n}"}
    email       {|n|"foo#{n}@bar.com"}
    password    "foobar"
  end


  factory :secret do
    sequence(:title) {|n| "Test message!"}  
    sequence(:body) {|n| "Test body"}   
    author
  end
end
