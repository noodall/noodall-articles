FactoryGirl.define do
  factory :home do |home|
    home.title { "Welcome" }
    home.body { Fakerama::Content.content }
    home.published_at { Time.now }
  end
end
