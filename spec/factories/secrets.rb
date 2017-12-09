FactoryBot.define do
  factory :secret do
    association :author, factory: :user

    title "MyString"
    body "MyText"
  end
end
