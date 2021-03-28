Feature: user login
 
  As a user
  So that I login to my account with my email and password

Scenario: empty email address
    Given I am on "Home" page
    And I fill in "Password" for login with "123"
    Then I press "Login"
    Then I should see "email is empty"

Scenario: empty password
    Given I am on "Home" page
    And I fill in "Email" for login with "123@columbia.edu"
    Then I press "Login"
    Then I should see "password is empty"

Scenario: invalid user
    Given I am on "Home" page
    And I fill in "Email" for login with "123@columbia.edu"
    And I fill in "Password" for login with "123"
    Then I press "Login"
    Then I should see "user does not exist, please register first"

Scenario: Log in successfully
    Given I am on "Home" page
    Given I am a valid user
    And I fill in "Email" for login with "123@columbia.edu"
    And I fill in "Password" for login with "123"
    Then I press "Login"
    Then I should see "Pokemon Eat"