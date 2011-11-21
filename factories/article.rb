FactoryGirl.define do
  factory :article do |article|
    article.title { Faker::Lorem.words(3).join(' ') }
    article.body { Fakerama::Content.content }
    article.published_at { Time.now }
    article.publish true
  end
end
