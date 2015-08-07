FactoryGirl.define do
  factory :user, aliases: [:author] do
    name  "Foo"
    sequence(:email) do |n| "foo#{n}@gmail.com" end
    password "password"
  end

  factory :secret do

    title     "Last summer"
    body      "liufrifuhriuofheuiohei qweiofuq iou"
    author 
  end
end