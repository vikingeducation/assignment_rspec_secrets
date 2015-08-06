FactoryGirl.define do
  factory :user do
    name  "Foo"
    email  "foo@bar.com"
    password "password"
  end

  factroy :secret do
    title     "secret"
    body      "liufrifuhriuofheuiohei qweiofuq iou"
    author_id 1
  end
end