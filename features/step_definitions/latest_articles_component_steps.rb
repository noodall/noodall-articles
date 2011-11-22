When /^I am editing a "([^"]*)" component$/ do |arg1|
  @content = Factory(:content_page)
  visit noodall_admin_node_path(@content)
  click_link "Small Slot"
  select "Latest Articles", from: "Select the type of component."
end

When /^I place a "([^"]*)" component in a slot$/ do |arg1|
  @content = Factory(:content_page)
  visit noodall_admin_node_path(@content)
  click_link "Small Slot"
  select "Latest Articles", from: "Select the type of component."
  select "News", from: "Article list"
  click_button "Save"
  sleep 2
  click_button "Publish"
end

When /^I view the content$/ do
  visit node_path(@content)
end

Then /^should see a list of the (\d+) latest articles in the slot$/ do |count|
  assert page.has_css?('ul#latest-articles li', :count => count.to_i)
end

Then /^I should be able to filter the articles that appear in the component by category$/ do
  sleep 2
  fill_in "node_small_slot_0_title", with: "Latest Articles" # Argh! Why "Title" no work?
  select "News", from: "Article list"
  click_button "Save"
  select "Stuff", from: "Category"
  sleep 2
  click_button "Publish"
end
