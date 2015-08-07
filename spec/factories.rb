FactoryGirl.define do
  factory :user, aliases: [:author] do
    name  "Foo"
    sequence(:email) do |n| "foo#{n}@gmail.com" end
    password "password"
  end

  factory :secret do

    # trait :author do
    #   after(:create) do |secret|
    #     secret.author_id = create(:user)
    #   end
    # end
    title     "secret"
    body      "liufrifuhriuofheuiohei qweiofuq iou"
    author
  end
end