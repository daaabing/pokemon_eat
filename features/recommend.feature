Feature: Recommend restaurants
    As a user
    I want to get recommendation about restaurants with/without terms

Background: users in database
  Given the following users exist:
  | email                        | password_digest | confirmed      | food_preference |
  | zhengchuan000@gmail.com      | 1               | 1              | chinese         |
  | 807442894@qq.com             | 1               | 1              | french          |
  | hzwang@ucdavis.edu           | 1               | 1              | korean          |
  | heyunong1223@gmail.com       | 1               | 1              |                 |

    Scenario: Recommend with term and location
        Given I am on "Home" page
        And I fill in "Email" for login with "zhengchuan000@gmail.com"
        And I fill in "Password" for login with "1"
        Then I press "Login"
        Then I press "Recommend"
        Then I should see "Recommend"
        And I fill in "Location" with ""

    