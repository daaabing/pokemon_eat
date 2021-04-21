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

    Scenario: Recommend with fun question and location and he will get on restaurtant detail page
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
        And I press "Recommend"
        Then I should see "Pick one"
        And I fill in "Place:" with "50 W 108th St, New York, NY 10025-3243, United States"
        Then I press "Recommend:"
        Then I should see "Here's What We Find Out"

    Scenario: Recommend without location and he will get error message
        Given I am on "Welcome" page
        And I fill in "Email" for login with "hzwang@ucdavis.edu"
        And I fill in "Password" for login with "1"
        Then I press "Login"
        And I press "Recommend"
        Then I press "Recommend:"
        Then I should see "location can not be empty!"
