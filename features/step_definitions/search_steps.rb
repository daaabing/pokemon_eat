Given /^I am on "(.*)" page$/ do |page_name|
  if page_name == "Search"
    visit '/search/1'
  elsif page_name == "Welcome"
    visit '/welcome'
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
  elsif field == "Place:"
      fill_in(:with => value, id: "recommend_location")
  else
      fill_in(field, :with => value)
  end
end

<a href="/" class="btn btn-primary" style="display:inline; color:white;">Log Out</a>
When /^(?:|I )follow "([^"]*)"$/ do |link|
  begin
    click_link(link)
  rescue
    if link == 'Log Out'
      click_link(link, href: '/')
    elsif link == 'POKEMON EAT'
      click_link(link, href: '/home')
    end
  end
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

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should see the number of restaurants is "(.*)"$/ do |assumed_num|
  actual_num = page.all(:css, 'li.business').size()
  expect(actual_num).to eq assumed_num.to_i
end