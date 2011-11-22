Factory.define :content_page do |content_page|
  content_page.title { Faker::Lorem.words(3).join(' ') }
  content_page.body { Faker::Lorem.paragraphs(6) }
  content_page.published_at { Time.now }
  content_page.publish true
end
