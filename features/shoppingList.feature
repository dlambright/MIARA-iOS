@shoppingList
Feature: Test the shopping list
    As a user
    When I tap on the shopping list button
    I need to see the shopping list
    I need to be able to add a grocery list item here
    and it needs to persist

Scenario: Shopping list screen
    Given the app has launched
    And I am on the home screen
    Then I touch the "shopping list" button
    Then I scroll down
    Then I touch the "+" button
    Then I use the native keyboard to enter "Calabash" into the "popup" input field
    Then I touch the return button
    Then I wait to see "Calabash"
    Then I wait for 2 seconds
    #Then I touch the "Miara" button
    #Then I wait to see "shopping list"
    #Then I touch the "shopping list" button
    #Then I scroll down
    #Then I wait to see "Calabash"
