FactoryBot.define do

  factory :user do
    name 'FooName'
    email "#{name}@email.com"
  end

  # factory :secret do
  #   title 'foo secret title'
  #   body 'foo secret body'
  #   author
  # end

end
