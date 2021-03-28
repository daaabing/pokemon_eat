Given /^I am on "(.*)" page$/ do |page_name|
  if page_name == "Search"
    visit '/search/1'
  else
    visit '/'
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  if field == "Category"
    fill_in(:with => value, id: "search_term")
  elsif field == "Nearby"
      fill_in(:with => value, id: "search_location")
  elsif field == "Location:"
      fill_in(:with => value, id: "event_location")
  else
      fill_in(field, :with => value)
  end
end


When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end


When /^(?:|I )press "(.*)"$/ do |button|
  click_button(button)
end

Then /^(?:|I )should see "(.*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see the number of restaurants is "(.*)"$/ do |assumed_num|
  actual_num = page.all(:css, 'li.business').size()
  expect(actual_num).to eq assumed_num.to_i
end