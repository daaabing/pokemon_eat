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
      Given I am on "Welcome" page
      And I fill in "Email" for login with "zhengchuan000@gmail.com"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      And the food preference of "zhengchuan000@gmail.com" should be "chinese"
      Then I am on the page of myself
      Then I should see "Edit My Profile"
      Then I follow "Log Out"
      Then I should see "Choosing Between Restaurants is Hard"

  Scenario: Log in successfully and see review
      Given I am on "Welcome" page
      And I fill in "Email" for login with "zhengchuan000@gmail.com"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      And the food preference of "zhengchuan000@gmail.com" should be "chinese"
      Then I am on the page of myself
      Then I should see "My Reviews"

  #The scenarios above and below prove that our session works correctly

  Scenario: Log in successfully
      Given I am on "Welcome" page
      And I fill in "Email" for login with "hzwang@ucdavis.edu"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      And the food preference of "hzwang@ucdavis.edu" should be "korean"
      Then I am on the page of myself

    Scenario: A user can go to restaurant detail page
      Given I am on "Welcome" page
      And I fill in "Email" for login with "hzwang@ucdavis.edu"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      Then I should see "Trending Restaurants"
      When I follow "Levain Bakery"
      Then I should see "167 W 74th St"
      Then I should see "(917) 464-3769"

    Scenario: A user can write a review for a restaurant and it shows on this restaurant detail page
    and a user can also like a restaurant, edit his profie and follow other user
      Given I am on "Welcome" page
      And I fill in "Email" for login with "zhengchuan000@gmail.com"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      Then I should see "Trending Restaurants"
      When I follow "Levain Bakery"
      Then I should see "Write a Review"
      And I press "Thumbs Up"
      Then I press "Write a Review"
      When I fill in "review" with "fantastic"
      Then I press "Post"
      Then I should see "fantastic"

      Then I am on the page of myself
      And I should see "Levain Bakery"
      Then I press "Edit"
      And I fill in "Nick Name" with "Peter"
      And I press "Save"
      Then I should see "Peter"
      Then I follow "Log Out"
      Then I should see "Choosing Between Restaurants is Hard"

      Given I am on "Welcome" page
      And I fill in "Email" for login with "heyunong1223@gmail.com"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      When I follow "Levain Bakery"
      And I press "Thumbs Up"
      Then I should see "fantastic"
      Then I should see "Peter"
      And I follow "Peter"
      And I press "Follow this user"

    Scenario: A user can go back to home page at reataurant detail page 
      Given I am on "Welcome" page
      And I fill in "Email" for login with "hzwang@ucdavis.edu"
      And I fill in "Password" for login with "1"
      Then I press "Login"
      Then I should see "Trending Restaurants"
      When I follow "Levain Bakery"
      Then I follow "POKEMON EAT"
      Then I should see "Trending Restaurants"
