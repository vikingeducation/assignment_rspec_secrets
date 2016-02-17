FactoryGirl.define do


  factory :user do
    first_name "Foo"
    last_name "Bar"
    email { "#{first_name}.#{last_name}@example.com" }
  end

  
end