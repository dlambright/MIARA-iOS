//
//  Model.swift
//  Miara
//
//  Created by Charlie Buckets on 12/16/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit
import SwiftyJSON
    

class Model: NSObject {
    
    private var apiKey : String!
    var recipeList = [Recipe]()
    var savedRecipes = [Recipe]()
    var cartedRecipes = [Recipe]()
    
    var recipeFilePath : String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as! NSURL
        return url.appendingPathComponent("recipeArray")!.path
    }
    
    var cartedFilePath : String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as! NSURL
        return url.appendingPathComponent("objectsArray")!.path
    }
    
    
    static let sharedInstance = Model() // Class Singleton
    
    override init(){
        super.init()
        // Get the API Key from the plist
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        self.apiKey = plist?.object(forKey: "Food2Fork_Api_Key") as! String
    }
    
    func searchRecipesWithString(searchString: String){
        
        let basicUrl = "http://www.food2fork.com/api/search?key=" + apiKey + "&q=" + searchString
        let eurl = URL(string: basicUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        let request = URLRequest(url: eurl)
        let session = URLSession.shared
        self.recipeList = [Recipe]()
        
        session.dataTask(with: request) {data, response, err in
            if let jsonData = data {
                
                let swiftyJson:JSON = JSON(data: jsonData)
                let count = swiftyJson["count"].intValue
                let recipeArray = swiftyJson["recipes"].arrayValue
                
                if (count > 0){
                    for i in (0...count-1){
                        var newRecipe:Recipe = Recipe(newJson: recipeArray[i])
                        
                        newRecipe = self.checkIfSearchResultRecipeIsAlreadySaved(recipe: newRecipe)
                        newRecipe = self.checkIfSearchResultRecipeIsAlreadyCarted(recipe: newRecipe)
                        
                        self.recipeList.append(newRecipe)
                    }
                }
            }
        }.resume()
    }
    
    func getIngredientsForRecipeWithId(id: String){
        
        var ingredients = [String]()
        let basicUrl = "http://food2fork.com/api/get?key=" + apiKey + "&rId=" + id
        let eurl = URL(string: basicUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        let request = URLRequest(url: eurl)
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            if let jsonData = data {
                
                let swiftyJson:JSON = JSON(data: jsonData)
                ingredients = self.sanitizeIngredientsList(ingredientsToTest: swiftyJson["recipe"]["ingredients"].arrayObject as! [String]!)
                
                self.setIngredientsForRecipeWithId(id: id, ingredients: ingredients)
            }
        }.resume()
    }
    
    private func setIngredientsForRecipeWithId(id: String, ingredients : [String]){
        for recipe in recipeList{
            if recipe.recipe_id == id{
                recipe.ingredients = ingredients
                break
            }
        }
    }
    
   func sanitizeIngredientsList(ingredientsToTest: [String])->[String]{
        var newIngredientList = [String]()
        
        for ingredient in ingredientsToTest{
            if (ingredient.characters.last != ":" &&
                ingredient.characters.last != ";" &&
                ingredient.characters.last != "_" &&
                ingredient.characters.first != "&" ){ // Bullshit dividers that get read in as ingredients, this might need to be expanded
                newIngredientList.append(ingredient)
            }

        }
        return newIngredientList
        
    }
    
    private func saveRecipesToDisk(){
        NSKeyedArchiver.archiveRootObject(self.savedRecipes, toFile: recipeFilePath)
    }
    
    func loadRecipesFromDisk(){
        if let array = NSKeyedUnarchiver.unarchiveObject(withFile: recipeFilePath) as? [Recipe] {
            self.savedRecipes = array
        }
    }
    
    
    func saveRecipe(recipe: Recipe){
        
        let queue = DispatchQueue(label: "Buckets.Charlie.Miara", attributes: .concurrent, target: .main)
        let myGroup = DispatchGroup()
        
        for alreadyIncludedRecipe in savedRecipes{
            if alreadyIncludedRecipe.recipe_id == recipe.recipe_id{
                return
            }
        }
                
        myGroup.enter()
        queue.async (group:myGroup){
            self.savedRecipes.append(recipe)
            if recipe.ingredients == nil || recipe.ingredients.count == 0{
                self.getIngredientsForRecipeWithId(id: recipe.recipe_id)
            }
            
            myGroup.leave()
        }
        
        
        myGroup.notify(queue: DispatchQueue.main) {
            self.saveRecipesToDisk()
        }
        


        
    }
    
    func removeSavedRecipe(recipe: Recipe){
        for i in 0...recipeList.count-1{
            if (recipeList[i].recipe_id == recipe.recipe_id){
                recipeList[i].saved = false
                recipeList[i].carted = false
                
                if savedRecipes.count > 0{
                    for j in 0...savedRecipes.count-1{
                        if savedRecipes[j].recipe_id == recipe.recipe_id{
                            savedRecipes.remove(at: j)
                            break
                        }
                    }
                }
                
                if cartedRecipes.count > 0{
                    for j in 0...cartedRecipes.count-1{
                        if cartedRecipes[j].recipe_id == recipe.recipe_id{
                            cartedRecipes.remove(at: j)
                            break
                        }
                    }
                }
                break
            }
        }
        saveRecipesToDisk()
    }
    
    func cartRecipe(recipe: Recipe){
        
    }
    
    func removeCartRecipe(recipe: Recipe){
        
    }
    
    func setSavedRecipesToCurrentRecipes(){
        self.recipeList = self.savedRecipes
    }
    
    func setCartedRecipesToCurrentRecipes(){
        self.cartedRecipes = [Recipe]()
        
        for recipe in savedRecipes{
            if recipe.carted == true{
                cartedRecipes.append(recipe)
            }
        }
        self.recipeList = cartedRecipes
    }
    
    func nukeAllRecipes(){
        for recipe in savedRecipes{
            self.removeSavedRecipe(recipe: recipe)
        }
    }
    
    func checkIfSearchResultRecipeIsAlreadySaved(recipe: Recipe)->Recipe{
        for savedRecipe in savedRecipes{
            if savedRecipe.recipe_id == recipe.recipe_id{
                return savedRecipe
            }
        }
        return recipe
    }
    
    func checkIfSearchResultRecipeIsAlreadyCarted(recipe: Recipe)->Recipe{
        for cartedRecipe in cartedRecipes{
            if cartedRecipe.recipe_id == recipe.recipe_id{
                return cartedRecipe
            }
        }
        return recipe
    }
    

}



