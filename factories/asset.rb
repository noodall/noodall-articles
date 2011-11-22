FactoryGirl.define do
  factory :asset do |asset|
    asset.tags { Faker::Lorem.words(4) }
    asset.title { "Image asset" }
    asset.description { "The asset description" }
    asset.file { Fakerama::Asset::Photo.landscape }
  end
end
