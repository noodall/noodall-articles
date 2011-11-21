Factory.define :article_list do |article_list|
  article_list.title { Faker::Lorem.words(3).join(' ') }
  article_list.body { Faker::Lorem.paragraphs(6) }
  article_list.published_at { Time.now }
  article_list.publish true
end
