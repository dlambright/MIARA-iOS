//
//  MiaraTests.swift
//  MiaraTests
//
//  Created by Charlie Buckets on 12/22/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import XCTest
@testable import Miara

class MiaraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testSlowCookerTacos() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://allrecipes.com/recipe/70343/slow-cooker-chicken-taco-soup/",
                                              recipeIngredientsList: ["1 onion, chopped", "1 (16 ounce) can chili beans", "1 (15 ounce) can black beans", "1 (15 ounce) can whole kernel corn, drained", "1 (8 ounce) can tomato sauce", "1 (12 fluid ounce) can or bottle beer", "2 (10 ounce) cans diced tomatoes with green chilies, undrained", "1 (1.25 ounce) package taco seasoning", "3 whole skinless, boneless chicken breasts", "1 (8 ounce) package shredded Cheddar cheese (optional)", "sour cream (optional)", "crushed tortilla chips (optional)"])
        XCTAssert(testResult.count == 2)
        
        if (testResult.count == 2){
            XCTAssert(testResult[0] == "Place the onion, chili beans, black beans, corn, tomato sauce, beer, and diced tomatoes in a slow cooker. Add taco seasoning, and stir to blend. Lay chicken breasts on top of the mixture, pressing down slightly until just covered by the other ingredients. Set slow cooker for low heat, cover, and cook for 5 hours."	)
            
            XCTAssert(testResult[1] == "Remove chicken breasts from the soup, and allow to cool long enough to be handled. Stir the shredded chicken back into the soup, and continue cooking for 2 hours. Serve topped with shredded Cheddar cheese, a dollop of sour cream, and crushed tortilla chips, if desired.")
        }
    }
    
    func testBestChocolateSheetRecipe() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://thepioneerwoman.com/cooking/2007/06/the_best_chocol/",
                                              recipeIngredientsList: ["2 cups Flour", "2 cups Sugar", "1/4 teaspoon Salt", "4 Tablespoons (heaping) Cocoa", "2 sticks Butter", "1 cup Boiling Water", "1/2 cup Buttermilk", "2 whole Beaten Eggs", "1 teaspoon Baking Soda", "1 teaspoon Vanilla", "_____", "1/2 cup Finely Chopped Pecans", "1-3/4 stick Butter", "4 Tablespoons (heaping) Cocoa", "6 Tablespoons Milk", "1 teaspoon Vanilla", "1 pound (minus 1/2 Cup) Powdered Sugar"])
        XCTAssert(testResult.count == 7)
        
        if (testResult.count == 7){
            XCTAssert(testResult[0] == "  Note: I use an 18x13 sheet cake pan. ")
            
            XCTAssert(testResult[4] == "In a measuring cup, pour the buttermilk and add beaten eggs, baking soda, and vanilla. Stir buttermilk mixture into butter/chocolate mixture. Pour into sheet cake pan and bake at 350-degrees for 20 minutes. ")
            
            XCTAssert(testResult[6] == "Cut into squares, eat, and totally wig out over the fact that you’ve just made the best chocolate sheet cake. Ever. ")
        }
    }
    
    func testRedVelvetCookieRecipe() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://www.twopeasandtheirpod.com/red-velvet-cheesecake-cookies/",
                                              recipeIngredientsList: ["1 box red velvet cake mix (I used Duncan Hines)", "2 tablespoons all-purpose flour", "2 large eggs", "1/2 cup canola oil", "1 teaspoon vanilla extract", "4 oz cream cheese, at room temperature", "2 cups powdered sugar", "1 teaspoon vanilla extract", "1 1/2 cups white chocolate chips, melted"])
        
        XCTAssert(testResult.count == 5)
        
        if (testResult.count == 5){
            XCTAssert(testResult[0] == "1. To make cookies, in a large bowl combine cake mix and flour. Whisk until clumps disappear. In the bowl of a stand mixer, mix together cake mix, flour, eggs, oil and vanilla extract. Mix until smooth. Wrap the dough in plastic wrap. The dough will be oily. Refrigerate for at least two hours.  ")
            
            XCTAssert(testResult[4] == "Note: if you are going to store the cookies for more than a day, you may want to keep them in the refrigerator. You can make the cookies smaller. Just use less dough and filling. You want to make sure you completely wrap the cookie dough around the filling before baking-so it doesn\'t leak. Enjoy!")
        }
    }
    
    func testChocolateSheetCakeWithPeanutButterFrosting() {
        
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://www.twopeasandtheirpod.com/chocolate-sheet-cake-with-peanut-butter-frosting/",
                                              recipeIngredientsList: ["2 cups granulated sugar", "2 cups all-purpose Gold Medal flour", "1 teaspoon baking soda", "1/2 teaspoon salt", "2 large eggs, lightly beaten", "1/2 cup buttermilk", "1 teaspoon pure vanilla extract", "1 cup unsalted butter", "1/4 cup cocoa powder", "1 cup hot water", "3 cups sifted powdered sugar", "1/2 cup milk", "1/2 cup creamy peanut butter", "1 teaspoon vanilla extract", "Reese's Peanut Butter Cups, chopped-optional"])
        
        
        XCTAssert(testResult.count == 5)
        
        if (testResult.count == 5){
            XCTAssert(testResult[0] == "1. To make the sheet cake: Preheat oven to 350 degrees. Grease a sheet pan with cooking spray and set aside. I use an 11 x 17 jelly roll pan.  ")
            
            XCTAssert(testResult[4] == "5. While the cake is baking, make the peanut butter frosting. In the bowl of a stand mixer, combine the sifted powdered sugar, milk, peanut butter, and vanilla extract. Beat with the beater blade until smooth. Frost the chocolate sheet cake as soon as you remove it from the oven. The peanut butter frosting will spread easily over the warm cake. Sprinkle chopped up Reese\'s Peanut Butter Cups over the frosting, if desired. Let the frosted cake cool to room temperature. Cut into squares and serve."	)
        }
    }
    
    func testCadburyCremeEggCake() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://www.mybakingaddiction.com/cadbury-creme-egg-cupcakes/",
                                              recipeIngredientsList: ["24 paper cupcake liners", "Batter for 24 cupcakes. Box mix works fine or simply use your favorite chocolate cupcake recipe, its your call.", "48 Mini Cadbury Creme Eggs (24 frozen) Youll use the frozen ones inside the cupcake batter. Freezing the eggs keeps them from completely vanishing inside the baked cake.", "1 batch of buttercream frosting", "yellow dye"])
        
        
        XCTAssert(testResult.count == 6)
        
        if (testResult.count == 6){
            XCTAssert(testResult[0] == "Scoop batter into paper liner 2/3 of the way full. Place one frozen Mini Cadbury Creme Egg into the middle of each cupcake. Use a spatula to spread the batter over the egg.")
            
            XCTAssert(testResult[5] == "Fill in the center of the circle with the yellow buttercream and top with a Mini Cadbury Cream Egg.")
        }
    }
    
    func testKnockYouNakedBrownies() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://thepioneerwoman.com/cooking/knock-you-naked-brownies/",
                                              recipeIngredientsList: ["1 box (18.5 Ounce) German Chocolate Cake Mix (I Used Duncan Hines)", "1 cup Finely Chopped Pecans", "1/3 cup Evaporated Milk", "1/2 cup Evaporated Milk (additional)", "1/2 cup Butter, Melted", "60 whole Caramels, Unwrapped", "1/3 cup Semi-Sweet Chocolate Chips", "1/4 cup Powdered Sugar"])
        
        
        XCTAssert(testResult.count == 7)
        
        if (testResult.count == 7){
            XCTAssert(testResult[0] == "  Preheat oven to 350 degrees.  ")
            
            XCTAssert(testResult[3] == "In a double boiler (or a heatproof bowl set over a saucepan of boiling water) melt caramels with additional 1/2 cup evaporated milk. When melted and combined, pour over brownie base. Sprinkle chocolate chips as evenly as you can over the caramel. ")
            
            XCTAssert(testResult[6] == "*Adapted from the classic \"Knock You Naked Brownies\" recipe, based on a dessert at the Salt Creek Steakhouse in Breckenridge. These brownies don\'t really knock you naked...but almost. ")
        }
    }
    
    func testRedVelvetCrinkleCookies() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://www.twopeasandtheirpod.com/red-velvet-crinkle-cookies/",
                                              recipeIngredientsList: ["1 box red velvet cake mix (I used Duncan Hines)", "2 tablespoons all-purpose flour", "2 large eggs", "1/2 cup canola oil", "1 teaspoon vanilla extract", "Powdered sugar, for rolling the cookies", "Heart shaped cookie cutter, optional"])
        
        
        
        XCTAssert(testResult.count == 4)
        
        if (testResult.count == 4){
            XCTAssert(testResult[0] == "1. Preheat oven to 350 degrees F. Line a large baking sheet with parchment paper or a Silpat and set aside. ")
            
            XCTAssert(testResult[3] == "Note-you don\'t have to cut the cookies into heart shapes. They are great round too!")
        }
    }
    
    func testCadburyCremeEggsBenedict() {
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://www.seriouseats.com/recipes/2010/03/cakespy-cadbury-creme-eggs-benedict-dessert-breakfast-recipe.html",
                                              recipeIngredientsList: ["2 Cadbury creme eggs", "1 plain cake doughnut", "1 brownie, the fudgier the better", "2 to 4 tablespoons' worth of buttercream frosting, to taste", "1 large slice pound cake, cut into small cubes", "1 tablespoons butter", "Red sugar sprinkles, to garnish"])
        XCTAssert(testResult.count == 8)
        
        if (testResult.count == 8){
            XCTAssert(testResult[0] == "1. Prepare the \"side potatoes\" by melting 1 tablespoon of butter in a frying pan. Add your cubed pound cake slices and fry on medium heat for about 2 minutes. Flip the pieces and fry for 2 more minutes. Once they are lightly crispy on the edges, they\'re ready; put them on the side of your serving plate, leaving half of it clear for the Benedict stacks.")
            
            XCTAssert(testResult[3] == "4. Note: While I realize that brownies might not have an accurate hue to represent the layer of ham, I chose them for their sturdy texture and for their deliciousness quotient. A pink cookie or layer of colored marzipan could be substituted if you really wanted a hammy look, though.")
            
            XCTAssert(testResult[7] == "8.")
        }
    }
    
    func testChocolateStrawberryNutellaCake(){
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://thepioneerwoman.com/cooking/2013/05/chocolate-strawberry-nutella-cake/",
                                              recipeIngredientsList: ["2 sticks Butter", "4 Tablespoons (heaping) Cocoa Powder", "1 cup Boiling Water", "2 cups Flour", "2 cups Sugar", "1/4 teaspoon Salt", "1/2 cup Buttermilk", "2 whole Eggs", "1 teaspoon Baking Soda", "1 teaspoon Vanilla", "1-1/2 cup Nutella", "2 pints Strawberries, Hulled And Sliced", "1/4 cup Sugar", "1 teaspoon Vanilla", "2 cups Heavy Cream", "1/2 cup Powdered Sugar"])
        XCTAssert(testResult.count == 9)
        
        if (testResult.count == 9){
            XCTAssert(testResult[0] == "  Preheat the oven to 350 degrees. Line 2 round baking pans with parchment, then spray the parchment with baking spray. ")
            
            XCTAssert(testResult[4] == "Pour the batter into the pans and bake them for 17-20 minute, until they\'re just set. Remove them from the pans and set them aside to cool completely. "	)
            
            XCTAssert(testResult[8] == "Note: Don\'t assemble more than an hour before serving. ")
        }
    }
    
    func testTheBestCoffeeCake(){
        let co : CardOrganizer = CardOrganizer()
        let testResult = co.getDirectionsList(url:"http://thepioneerwoman.com/cooking/the-best-coffee-cake-ever/",
                                              recipeIngredientsList: ["1-1/2 stick Butter, Softened", "2 cups (scant) Sugar", "3 cups Flour, Sifted", "4 teaspoons Baking Powder", "1 teaspoon Salt", "1-1/4 cup Whole Milk", "3 whole Egg Whites, Beaten Until Stiff", "1-1/2 stick Butter, Softened", "3/4 cups Flour", "1-1/2 cup Brown Sugar", "2 Tablespoons Cinnamon", "1-1/2 cup Pecans, Chopped"])
        XCTAssert(testResult.count == 4)
        
        if (testResult.count == 4){
            XCTAssert(testResult[0] == "  Preheat oven to 350 degrees. Sift together flour, baking powder, and salt. Beat egg whites and set aside.  "	)
            
            XCTAssert(testResult[3] == "Bake for 40 to 45 minutes, or until no longer jiggly. Serve warm---delicious! ")
            

        }
    }
    
}

















