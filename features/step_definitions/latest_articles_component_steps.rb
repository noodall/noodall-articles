Then /^I should be able to add a "([^"]*)" component$/ do |component|
  click_link "Small Slot"
  click_button "Save"
end

When /^I am editing a "([^"]*)" component$/ do |arg1|
  @content = Factory(:content_page)
  visit noodall_admin_node_path(@content)
  click_link "Small Slot"
end

Then /^I should be able to filter the articles that appear in the component by sector, region or category$/ do
  select "Latest Articles", from: "Select the type of component."
  fill_in "node_small_slot_0_title", with: "Latest Articles" # Argh! Why "Title" no work?
  select "Bristol", from: "Region"
  select "Construction", from: "Sector"
  click_button "Save"
  sleep 2
  click_button "Publish"
end

Then /^I should be able to filter by a combination of any of the above$/ do
  visit node_path(@content)
  page.should have_css("div.latest-articles h3", text: "Latest Articles")
  page.should have_css('ol.latest-articles-list li')
end