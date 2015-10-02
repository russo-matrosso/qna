FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@text.com"
  end

  factory :user do
    email
    password 'foobarfoobar'
    password_confirmation 'foobarfoobar'
  end

end
