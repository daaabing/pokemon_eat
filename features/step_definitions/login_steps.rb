Given(/^I'm in a login page$/) do
  visit '/welcome'
end

Then(/^I should see "([^"]*)"$/) do |arg|
  page.has_content?(text)
end

When(/^I fill in (.*) with (.*)$/) do |email, password|
  fill_in(email, :with => email)
end

Then(/^I follow "([^"]*)"$/) do |arg|
  click_link(link)
end

Then(/^I will be navigated to my home page$/) do
  visit '/show'
end

Then(/^I will not be navigated to my home page$/) do
  visit '/'
end

