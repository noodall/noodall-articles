FactoryGirl.define do
  factory :user do
    email      { |u| Faker::Internet.email(u.full_name) }
    full_name  { Faker::Name.name }
  end
end
