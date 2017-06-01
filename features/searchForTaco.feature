@foodSearch
Feature: Search for a food
    As a user
    I want to search for a food
    And see it on the next screen

Scenario:
    Given the app has launched
    And I am on the home screen
    Then I touch the "textBox" input field
    Then I use the native keyboard to enter "taco" into the "textBox" input field
    Then I touch "search"
    Then I wait to see "search results for taco"
    Then I wait to see "Taco Pizza"
    Then I wait to see "How to Make a Choco Taco"
    Then I wait to see "Homemade Chili and Taco Seasoning"
    Then I scroll down
    Then I scroll down
    Then I scroll down
    Then I go back
    Then I touch the "textBox" input field
    Then I use the native keyboard to enter "taco" into the "textBox" input field
    Then I touch "search"
    Then I wait to see "search results for taco"
    Then I wait to see "Taco Pizza"
    Then I wait to see "How to Make a Choco Taco"
    Then I wait to see "Homemade Chili and Taco Seasoning"
    Then I scroll down
    Then I scroll down
    Then I scroll down

