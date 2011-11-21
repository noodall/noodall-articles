FactoryGirl.define do
  factory :article_list do |article_list|
    article_list.title { Faker::Lorem.words(3).join(' ') }
    article_list.published_at { Time.now }
    article_list.publish true
  end
end
