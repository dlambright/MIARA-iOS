@recipeSave
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
Then I use the native keyboard to enter "taco quesadilla pizza" into the "textBox" input field
Then I touch "search"
Then I wait to see "search results for taco quesadilla pizza"
Then I wait to see "Taco Quesadilla Pizzas"
Then I wait for 1 second
Then I touch list item number 1
Then I wait for 1 second
Then I should see a "saveRecipe" button
Then I wait for 1 second
Then I touch the "saveRecipe" button
Then I go back
Then I go back
Then I should see a "saved recipes" button
Then I touch the "saved recipes" button
Then I should see "Taco Quesadilla Pizzas"
