Feature: create a user profile
  As a new user
  So that I can create my profile

Scenario: empty email address
    Given I am on "Welcome" page
    And I fill in "Password:" for signup with "123"
    And I fill in "Re-Password:" for signup with "123"
    Then I press "SignUp"
    Then I should see "Email is empty"

Scenario: empty password
    Given I am on "Welcome" page
    And I fill in "Email" for signup with "123@columbia.edu"
    And I fill in "Password:" for signup with "123"
    And I fill in "Re-Password" for signup with "456"
    Then I press "SignUp"
    Then I should see "Password and Re-password do not match"

Scenario: signed up successfully
    Given I am on "Welcome" page
    And I fill in "Email" for signup with "123123@qq.com"
    And I fill in "password" for signup with "!@#123"
    And I fill in "re_password" with "!@#123"
    And I fill in "hometown" with "New York"
    And I fill in "nick_name" with "Julie"
    Then I press "SignUp"
    Then I should see "Pick Up Some Food"
    And I follow "Chinese"
    And I press "Submit"
    And I should see "Get restaurant based on your preference!"
