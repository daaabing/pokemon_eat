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
  if field == "Find Cuisine"
      fill_in('term', :with => value, id: "search_term")
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

When /^(?:|I )follow "([^"]*)"$/ do |link|
  begin
    click_link(link)
  rescue
    if link == 'Log Out'
      redirect_to '/'
    elsif link == 'POKEMON EAT'
      page.click_link('', :href => '/home')
    elsif link == 'Chinese'
      check(link)
    end
  end
end


When /^(?:|I )press "(.*)"$/ do |button|
  
  if button == 'Recommend'
    click_button(button,class: ['btn btn-secondary'])
  elsif button == 'Recommend:'
    click_button('Recommend',class: ['btn btn-primary'])
  elsif button == 'Go for the event'
    click_button(button,class: ['btn btn-primary'])
  else
    click_button(button)
  end
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