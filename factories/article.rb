Factory.define :article do |article|
  article.title { Faker::Lorem.words(3).join(' ') }
  article.body { Faker::Lorem.paragraphs(6) }
  article.published_at { Time.now }
  article.publish true
end
