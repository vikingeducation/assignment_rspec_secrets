FactoryGirl.define do


  factory :user do
    name "Foobar"
    email { "#{name}@example.com" }
    password "qwerqwer"
  end


end
