@keyboard
Feature: Retire the keyboard when cancelling
    As a user
    When I have the keyboard visible
    Then I tap outside of the keyboard
    The keyboard should dissappear

Scenario: Retire Keyboard
    Given the app has launched
    And I am on the home screen
    Then I touch the "textBox" input field
    Then I touch on screen 300 from the left and 300 from the top
    Then I wait for 3 seconds
    Then I touch "shopping list"
    Then I wait to see "Miara"
    Then I touch "Miara"
