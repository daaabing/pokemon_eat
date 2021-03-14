Feature: create a user profile
 
  As a new user
  So that I can create my profile

Scenario: empty email address
    Given I am on "Home" page
    And I fill in "Password" for signup with "123"
    And I fill in "Re-Password" for signup with "123"
    Then I press "SignUp"
    Then I should see "email is empty"

Scenario: empty password
    Given I am on "Home" page
    And I fill in "Email" for signup with "123@columbia.edu"
    And I fill in "Password" for signup with "123"
    And I fill in "Re-Password" for signup with "456"
    Then I press "SignUp"
    Then I should see "Password and Re-password do not match!"

Scenario: signed up successfully
    Given I am on "Home" page
    And I fill in "Email" for signup with "123123@qq.com"
    And I fill in "Password" for signup with "123"
    And I fill in "Re-Password" with "123"
    Then I press "SignUp"
    Then I should see "Confirmed"
