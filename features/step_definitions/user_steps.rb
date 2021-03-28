When /^(?:|I )fill in "([^"]*)" for signup with "([^"]*)"$/ do |field, value|
    if field == "Email"
        fill_in(:with => value, id: "signup_email")
    elsif field == "Password"
        fill_in(:with => value, id: "signup_password")
    else
        fill_in(field, :with => value)
    end
end

When /^(?:|I )fill in "([^"]*)" for login with "([^"]*)"$/ do |field, value|
    if field == "Email"
        fill_in(:with => value, id: "login_email")
    elsif field == "Password"
        fill_in(:with => value, id: "login_password")
    else
        fill_in(field, :with => value)
    end
end



When /^(?:|I )fill in "([^"]*)" for recommend with "([^"]*)"$/ do |field, value|    
    fill_in(field, :with => value, id: "recommend_location")
end



Given /^I am a valid user$/ do
    User.create(email: "123@columbia.edu", password_digest: "123")
end