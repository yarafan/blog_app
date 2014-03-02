FactoryGirl.define do
  factory :user do
    name     "Yara"
    email    "yara@mail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end