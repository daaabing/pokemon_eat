Feature: homepage for users
  As a user
  I want to see my email address and food preference on the homepage

Background: users in database
  Given the following users exist:
  | email            | password_digest | confirmed  | food_preference |
  | abc@111.com      | abc111          | abc111     | chinese         |
  | edf@222.com      | edf222          | edf222     | french          |
  | test@33.com      | test33          | test33     |                 |
  
#Scenario: user homepage
#  When I am on the page of "users"
#  Then I should see "abc@111.com"
#  But I should not see "test@gamil.com"
#  And the food preference of "abc@111.com" should be "chinese"
#
#Scenario: user homepage
#  When I am on the page of "users"
#  Then I should see "test@33.com"
#  And the food preference of "test@33.com" should be "empty"

Scenario: Log in successfully
    Given I am on "Home" page
    And I fill in "Email" for login with "test@33.com"
    And I fill in "Password" for login with "test33"
    Then I press "Login"
    And the food preference of "test@33.com" should be "empty"

Scenario: Log in successfully
    Given I am on "Home" page
    Given I am a valid user
    And I fill in "Email" for login with "123@columbia.edu"
    And I fill in "Password" for login with "123"
    Then I press "Login"
    And the food preference of "123@columbia.edu" should be "empty"