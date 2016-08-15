FactoryGirl.define do

  factory :secret do
    title "This is my secret"
    body "Please don't tell"

    author
  end

end
