@touchThreeLists
Feature: Touch three shopping lists in the table view
    As a user
    When I search for a food
    And I am on the results screen
    I want to tap the first three shopping list buttons
    Thus saving them to the iPhone

Scenario: Touch three lists
    Given the app has launched
    And I am on the home screen
    Then I touch the "textBox" input field
    Then I use the native keyboard to enter "taco" into the "textBox" input field
    Then I touch "search"
    Then I wait to see "search results for taco"
    Then I touch the "tableViewListButton" button
