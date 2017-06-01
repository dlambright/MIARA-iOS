@deleteShoppingListItems
Feature: Test the shopping list
    As a user
    When I tap on the shopping list button
    I need to see the shopping list
    And view the recipes
    Then delete the Calabash item

Scenario: Shopping list deletion
    Given the app has launched
    And I am on the home screen
    Then I touch the "shopping list" button
    Then I wait to see "Calabash"
    Then I swiggity-swipe left on the cell with name "Calabash"
    Then I touch "Delete"
