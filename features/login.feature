Feature: Test login functionality



  Background: account and password in database

#    Given the following accounts and passwords:
#    Examples:
#      | email                 | password          |
#      | zhengchuan000@gmail.com  | 123456            |
#      | 807442894@qq.com         | 12345             |
#      | heyunong1223@gmail.com   | 1234              |
#      | hzwang@ucdavis.edu       | 123               |

  Scenario : a check login is successful with valid credentials
    Given I'm in a login page
    Then  I should see "Welcome to Pokemon Eat!"
    When  I fill in <email> with <password>
    Then  I follow "Login"
    Then  I will be navigated to my home page
    Examples:
      | email                    | password          |
      | zhengchuan000@gmail.com  | 123456            |
      | 807442894@qq.com         | 12345             |
      | heyunong1223@gmail.com   | 1234              |
      | hzwang@ucdavis.edu       | 123               |

  Scenario: Enter an empty email and password
    Given I'm in a login page
    Then  I should see "Welcome to Pokemon Eat!"
    When  I fill in <email> with <password>
    Then  I follow "Login"
    Then  I will not be navigated to my home page
    And   I should see "email is empty"
    And   I should see "password is empty"
    Examples:
      | email                 | password          |
      | zhengchuan000@gmail.com  | 123456            |
      | 807442894@qq.com         | 12345             |
      | heyunong1223@gmail.com   | 1234              |
      | hzwang@ucdavis.edu       | 123               |

  Scenario: A user doesn't have an account
    Given I'm in a login page
    Then  I should see "Welcome to Pokemon Eat!"
    When  I fill in <email> with <password>
    Then  I follow "Login"
    Then  I will not be navigated to my home page
    And   I should see "user does not exist, please register first"
    Examples:
      | email                 | password          |
      | zhengchuan000@gmail.com  | 123456            |
      | 807442894@qq.com         | 12345             |
      | heyunong1223@gmail.com   | 1234              |
      | hzwang@ucdavis.edu       | 123               |