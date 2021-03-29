# Feature: homepage for users
#   As a user
#   I want to see my email address and food preference on the homepage

# Background: users in database
#   Given the following users exist:
#   | email                        | password_digest | confirmed      | food_preference |
#   | zhengchuan000@gmail.com      | 1               | 1              | chinese         |
#   | 807442894@qq.com             | 1               | 1              | french          |
#   | hzwang@ucdavis.edu           | 1               | 1              | korean          |
#   | heyunong1223@gmail.com       | 1               | 1              |                 |
      
# Scenario: Log in and Log out successfully
#     Given I am on "Home" page
#     And I fill in "Email" for login with "zhengchuan000@gmail.com"
#     And I fill in "Password" for login with "1"
#     Then I press "Login"
#     And the food preference of "zhengchuan000@gmail.com" should be "empty"
#     Then I follow "zhengchuan000@gmail.com"
#     Then I follow "Log out"
#     Then I should see "Welcome to Pokemon Eat!"

# Scenario: Log in successfully
#     Given I am on "Home" page
#     Given I am a valid user
#     And I fill in "Email" for login with "123@columbia.edu"
#     And I fill in "Password" for login with "123"
#     Then I press "Login"
#     And the food preference of "123@columbia.edu" should be "empty"
#     Then I follow "123@columbia.edu"
#     Then I should see "User Profile"

# Scenario: Log in successfully
#     Given I am on "Home" page
#     And I fill in "Email" for login with "hzwang@ucdavis.edu"
#     And I fill in "Password" for login with "1"
#     Then I press "Login"
#     And the food preference of "hzwang@ucdavis.edu" should be "empty"
#     Then I follow "hzwang@ucdavis.edu"
#     Then I follow "Back to home page"
#     Then I should see "Get restaurant based on your preference!"



Feature: homepage for users
  As a user
  I want to see my email address and food preference on the homepage

Background: users in database
  Given the following users exist:
  | email                        | password_digest | confirmed      | food_preference |
  | zhengchuan000@gmail.com      | 1               | 1              | chinese         |
  | 807442894@qq.com             | 1               | 1              | french          |
  | hzwang@ucdavis.edu           | 1               | 1              | korean          |
  | heyunong1223@gmail.com       | 1               | 1              |                 |
      
Scenario: Log in and Log out successfully
    Given I am on "Home" page
    And I fill in "Email" for login with "zhengchuan000@gmail.com"
    And I fill in "Password" for login with "1"
    Then I press "Login"
    And the food preference of "zhengchuan000@gmail.com" should be "chinese"
    Then I follow "zhengchuan000@gmail.com"
    Then I follow "Log out"
    Then I should see "Welcome to Pokemon Eat!"

Scenario: Log in successfully
    Given I am on "Home" page
    Given I am a valid user
    And I fill in "Email" for login with "123@columbia.edu"
    And I fill in "Password" for login with "123"
    Then I press "Login"
    And the food preference of "123@columbia.edu" should be "empty"
    Then I follow "123@columbia.edu"
    Then I should see "User Profile"

#The scenarios above and below prove that our session works correctly

Scenario: Log in successfully
    Given I am on "Home" page
    And I fill in "Email" for login with "hzwang@ucdavis.edu"
    And I fill in "Password" for login with "1"
    Then I press "Login"
    And the food preference of "hzwang@ucdavis.edu" should be "korean"
    Then I follow "hzwang@ucdavis.edu"
    Then I follow "Back to home page"
    Then I should see "Get restaurant based on your preference!"

  Scenario: A user can go to restaurant detail page
    Given I am on "Home" page
    And I fill in "Email" for login with "hzwang@ucdavis.edu"
    And I fill in "Password" for login with "1"
    Then I press "Login"
    Then I should see "Trending Restaurants"
    When I follow "Levain Bakery"
    Then I should see "167 W 74th St"
    Then I should see "(917) 464-3769"

  Scenario: A user can write a review for a restaurant and it shows on this restaurant detail page
    Given I am on "Home" page
    And I fill in "Email" for login with "hzwang@ucdavis.edu"
    And I fill in "Password" for login with "1"
    Then I press "Login"
    Then I should see "Trending Restaurants"
    When I follow "Levain Bakery"
    Then I should see "Write a Review"
    Then I should see "Back to home page"
    Then I follow "Write a Review"
    Then I should see "You are in Review"
    When I fill in "review" with "fantastic"
    Then I press "Post"
    Then I should see "From user:"
    Then I should see "fantastic"


  Scenario: A user can go back to home page at reataurant detail page 
    Given I am on "Home" page
    And I fill in "Email" for login with "hzwang@ucdavis.edu"
    And I fill in "Password" for login with "1"
    Then I press "Login"
    Then I should see "Trending Restaurants"
    When I follow "Levain Bakery"
    Then I should see "Back to home page"
    Then I follow "Back to home page"
    Then I should see "Trending Restaurants"
