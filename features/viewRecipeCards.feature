@recipeCard
Feature: observe recipe cards
As a user
I want to search for a food
And see it on the next screen
Then touch the recipe card button
And see a stack of my recipe instruction cards

Scenario:
Given the app has launched
And I am on the home screen
Then I touch the "textBox" input field
Then I use the native keyboard to enter "taco pizza" into the "textBox" input field
Then I touch "search"
Then I wait to see "search results for taco pizza"
Then I wait to see "Taco Pizza"
Then I wait for 1 second
Then I touch list item number 1
Then I wait for 1 second
Then I should see a "cards" button
Then I wait for 4 seconds
Then I touch the "cards" button
