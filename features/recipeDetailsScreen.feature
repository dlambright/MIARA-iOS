@detailsScreen
Feature: Test the recipe details screen
    As a user
    When I tap on a recipe card from a search
    I need to see the recipe details screen with ingredients
    With a link to the recipe's blog
    No ipmorta si esta escrita en ingles o no

Scenario: Recipe details screen
    Given the app has launched
    And I am on the home screen
    Then I touch the "textBox" input field
    Then I use the native keyboard to enter "taco" into the "textBox" input field
    Then I touch "search"
    Then I wait to see "search results for taco"
    Then I wait for 1 second
    Then I touch list item number 1
    Then I wait for 1 second
    Then I should see a "link" button
    Then I touch the "link" button
    Then I wait for 2 seconds
    Then I go back
    Then I wait for 3 seconds









