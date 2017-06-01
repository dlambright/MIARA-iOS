Feature: Saved Recipes Smoke Test
    As a user
    I want to check if there are any saved recipes

Scenario: Saved Recipes Smoke Test
    Given the app has launched
    And I am on the home screen
    Then I touch "saved recipes"
    Then I wait to see "my saved recipes"
    


