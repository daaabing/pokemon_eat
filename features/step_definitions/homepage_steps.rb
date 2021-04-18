Given('the following users exist:') do |table|
    table.hashes.each do |hash|
        User.create hash
    end 
  end

When /^I am on the page of myself$/ do
    visit '/user'
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
    regexp = Regexp.new(regexp)
  
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
    if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end

Then /^the food preference of "(.*)" should be "(.*)"$/ do |email_name, food|
    user = User.find_by_email(email_name)
    pre = user.food_preference
    if pre == "" || pre.nil?
      expect("empty").to eq food
    else
      expect(pre).to eq food
    end
  end
  