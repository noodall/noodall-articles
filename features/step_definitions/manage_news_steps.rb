Given /^I am on the tree admin page$/ do
  visit noodall_admin_nodes_path
end

Given /^I navigate to the 'News' branch$/ do
  click_link "View content under News"
end

Then /^I should be able to add Articles the News branch$/ do
  click_link "Add content under News"
  page.should have_css("fieldset.template input[type='radio']", count: 1)
  choose "Article"
  fill_in 'Title', with: "A brand new article"
  click_button "Create"
  page.should have_content "Article 'A brand new article' was successfully created."
end

Given /^I am editing an Article$/ do
  @article = Factory :article
  visit noodall_admin_node_path(@article)
end

Given /^articles exist with categories assigned$/ do
  10.times do
    Factory :article, :categories => ['stuff', 'things']
  end
end

When /^I start typing in the categories field$/ do
  fill_in "Categories", with: "st"
end

Then /^I should see suggestions of existing categories I could assign to the article$/ do
  page.should have_css(".ui-menu-item", count: 1)
end

Then /^I should be able to assign the article to multiple new or existing categories$/ do
  find("a.ui-corner-all").click # select the categories from the autocompleter
  click_button "Publish"
  @article.reload
  @article.categories.should include("Stuff")
end

Then /^I should be able to choose a Sector that the article relates to$/ do
  select "Manufacturing", from: "Sectors"
  click_button "Publish"
  @article.reload
  @article.sectors.should include("Manufacturing")
end

Then /^I should assign the article as relevant to all Sectors$/ do
  select "All", from: "Sectors"
  click_button "Publish"
  @article.reload
  @article.sectors.should include("All")
end

When /^I add an image to the body of an article$/ do

  # Add the new article under the news page
  @article.parent = ArticleList.find_by_permalink('news')

  # Create an asset
  asset = Factory :asset

  # Use it's attributes to add an image to the body text
  @article.body = %{<p><img id="asset-#{asset._id}" class="fancy" title="#{asset.file_name}" src="#{asset.url('110x110', asset.web_image_extension)}" alt="#{asset.file_name}" /></p>}
  @article.save
end

Then /^it should be used as the article thumbnail$/ do
  visit "/news"
  page.should have_css("div.article-image img")
end