Given /^there are many news articles$/ do
  @news_page = ArticleList.find_by_permalink('news')
  11.times do
    Factory :article, parent: @news_page
  end
end

When /^I go to the News section of the website$/ do
  visit node_path(@news_page)
end

Then /^I should see a paginated list of articles$/ do
  page.should have_css("ul#articles li", count: 10)
  page.should have_content("Previous 1 2 Next")
end

Given /^there are many news articles that have been created over the last few years$/ do
  @news_page = ArticleList.find_by_permalink('news')
  ["2010-10-23", "2010-10-23", "2009-9-3", "2008-1-13"].each do |date|
    Factory :article, parent: @news_page, published_at: date
  end
end

Then /^should see an archive list in the sidebar$/ do
  page.should have_css("ul#archive-list")
end

Then /^I should be able use it to view articles to by specific month or year$/ do

  # Year
  visit node_path(@news_page, year: "2010")
  page.should have_css("ul#articles li", count: 2)

  # Year and month
  visit node_path(@news_page, year: "2009", month: "9")
  page.should have_css("ul#articles li", count: 1)
end

Given /^there are many news articles assigned to Categories$/ do
  @news_page = ArticleList.find_by_permalink('news')
  ["Stuff", "Things", "Foo", "Bar"].each do |category|
    3.times do
      Factory :article, parent: @news_page, categories: category
    end
  end
end

Then /^I should see a list of Categories within the sidebar$/ do
  page.should have_css("ul#categories-list a", count: 4)
end

Then /^when I choose a Category$/ do
  click_link "Things"
end

Then /^I should see only articles assigned to the Category$/ do
  page.should have_css("ul#articles li", count: 3, text: "Things")
end

Then /^I should see the (\d+) most recent articles in the sidebar$/ do |number_of_articles|
  page.should have_css("ol#latest-article-list li a", count: number_of_articles)
end

When /^I view an article$/ do
  @news_page = ArticleList.find_by_permalink('news')
  article = Factory :article, parent: @news_page, tags: "Foo"
  @related_article = Factory :article, parent: @news_page, title: "Related page", tags: "Foo"
  visit node_path(article)
end

Then /^I should see Articles related to the one I am viewing in the sidebar$/ do
  page.should have_css("ul#related-articles li", count: 1, text: "Related page")
end

Then /^the relation should be based on keywords$/ do
  @related_article.tags.should include("Foo")
end

Then /^I should be able to subscribe to an RSS feed$/ do
  visit "/news"
  click_link "RSS"
  page.should have_css("item", count: 4)
end

Then /^the RSS feed should reflect the filters$/ do
  click_link "RSS"
  page.should have_css("item", count: 1)
end
