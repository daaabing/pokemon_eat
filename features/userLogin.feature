Feature: user login
  As a user
  So that I login to my account with my email and password

Scenario: empty email address
    Given I am on "Welcome" page
    And I fill in "Password" for login with "123"
    Then I press "Login"
    Then I should see "Email is empty"

Scenario: empty password
    Given I am on "Welcome" page
    And I fill in "Email" for login with "123@columbia.edu"
    Then I press "Login"
    Then I should see "Password is empty"

Scenario: invalid user
    Given I am on "Welcome" page
    And I fill in "Email" for login with "123@columbia.edu"
    And I fill in "Password" for login with "123"
    Then I press "Login"
    Then I should see "User does not exist, please sign up first"

Scenario: Log in successfully
    Given I am on "Welcome" page
    And I fill in "Email" for login with "heyunong1223@gmail.com"
    And I fill in "Password" for login with "1"
    Then I press "Login"
    Then I should see "Pokemon Eat"