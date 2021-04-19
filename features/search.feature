Feature: Search restaurant with/without terms and locations
    As a user
    I want to search restaurants with/without terms

Background: users in database
  Given the following users exist:
  | email                        | password_digest | confirmed      | food_preference |
  | zhengchuan000@gmail.com      | 1               | 1              | chinese         |
  | 807442894@qq.com             | 1               | 1              | french          |
  | hzwang@ucdavis.edu           | 1               | 1              | korean          |
  | heyunong1223@gmail.com       | 1               | 1              |                 |

    Scenario: Search with term and location
        Given I am on "Welcome" page
        And I fill in "Email" for login with "zhengchuan@gmail.com"
        And I fill in "Password" for login with "1"
        Then I press "Login"
        And I fill in "Category" with "chinese"
        And I fill in "Nearby" with "New York"
        And I press "Go"
        Then I should see "Searching Restaurants"

    Scenario: Search without location
        Given I am on "Welcome" page
        And I fill in "Email" for login with "zhengchuan@gmail.com"
        And I fill in "Password" for login with "1"
        Then I press "Login"
        And I fill in "Category" with "chinese"
        And I press "Go"
        Then I should see "location can not be empty"

    Scenario: Search without term
        Given I am on "Welcome" page
        And I fill in "Email" for login with "zhengchuan@gmail.com"
        And I fill in "Password" for login with "1"
        Then I press "Login"
        And I fill in "Nearby" with "New York"
        And I press "Go"
        Then I should see "Searching Restaurants"

    Scenario: Search event
        Given I am on "Welcome" page
        And I fill in "Email" for login with "zhengchuan@gmail.com"
        And I fill in "Password" for login with "1"
        Then I press "Login"
        And I fill in "Location" with "New York"
        And I press "Go for the event"
        Then I should see "Trending Events"