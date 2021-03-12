Feature: Search restaurant with/without terms and locations
    As a user
    I want to search restaurants with/without terms 

Scenario: Search with term and location
    Given I am on "Search" page
    When I fill in "term" with "seafood"
    And I fill in "location" with "NewYork"
    And I press "Search"
    Then I should see the number of restaurants is "5"

Scenario: Search without location
    Given I am on "Search" page
    When I fill in "term" with "seafood"
    And I press "Search"
    Then I should see the number of restaurants is "0"
    Then I should see "location can not be empty"

Scenario: Search without term
    Given I am on "Search" page
    When I fill in "location" with "NewYork"
    And I press "Search"
    Then I should see the number of restaurants is "5"
