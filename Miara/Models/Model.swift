//
//  Model.swift
//  Miara
//
//  Created by Charlie Buckets on 12/16/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Recipe

class Model: NSObject {
    
    private var apiKey : String!
    var customItemsRecipe : Recipe!
    var recipeList = [Recipe]()
    var savedRecipes = [Recipe]()
    var cartedRecipes = [Recipe]()
    
    var recipeFilePath : String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        return url.appendingPathComponent("recipeArray")!.path
    }
    
    var cartedFilePath : String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        return url.appendingPathComponent("objectsArray")!.path
    }
    
    var customRecipeFilePath : String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        return url.appendingPathComponent("custom")!.path
    }
    
    
    static let sharedInstance = Model() // Class Singleton
    
    override init(){
        super.init()
        // Get the API Key from the plist
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        self.apiKey = plist?.object(forKey: "Food2Fork_Api_Key") as! String
    }
    
    private func searchRecipesWithString(searchString: String, pageNumber: Int, callback: @escaping (_ data: NSData) -> ()) {
        
        let basicUrl = "http://www.food2fork.com/api/search?key=\(apiKey as String)&q=\(searchString)&page=\(String(pageNumber))"
        let eurl = URL(string: basicUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        let request = URLRequest(url: eurl)
        let session = URLSession.shared
//        self.recipeList = [Recipe]()
        
        session.dataTask(with: request) {data, response, err in
            callback(data! as NSData)
        }.resume()
    }
    
    func searchRecipesWithString(searchString: String, pageNumber: Int){
        
        self.searchRecipesWithString(searchString: searchString, pageNumber : pageNumber , callback: { (data) in
            let jsonData = data
                
            let swiftyJson:JSON = JSON(data: jsonData as Data)
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
        })
    }
    
    

    func getIngredientsForRecipeWithId(id: String, callback: @escaping (_ data: NSData) -> ()) {
        
        let basicUrl = "http://food2fork.com/api/get?key=" + apiKey + "&rId=" + id
        let eurl = URL(string: basicUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        let request = URLRequest(url: eurl)
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            callback(data! as NSData)
        }.resume()
    }
    
    func setIngredientsAndSave(recipe: Recipe){
        self.getIngredientsForRecipeWithId(id: recipe.recipe_id, callback: { (data) in
            let jsonData = data
            let swiftyJson:JSON = JSON(data: jsonData as Data)
            let ingredients = self.sanitizeIngredientsList(ingredientsToTest: swiftyJson["recipe"]["ingredients"].arrayObject as! [String]!)
            self.setIngredientsForRecipeWithId(id: recipe.recipe_id, ingredients: ingredients)
            self.saveRecipe(recipe: recipe)

        })
    }
    
    func setIngredients(recipe: Recipe){
        self.getIngredientsForRecipeWithId(id: recipe.recipe_id, callback: { (data) in
            let jsonData = data
            let swiftyJson:JSON = JSON(data: jsonData as Data)
            let ingredients = self.sanitizeIngredientsList(ingredientsToTest: swiftyJson["recipe"]["ingredients"].arrayObject as! [String]!)
            self.setIngredientsForRecipeWithId(id: recipe.recipe_id, ingredients: ingredients)
        })
    }
    
    func setIngredientsForRecipeWithId(id: String, ingredients : [String]){
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
            
            var tempIngredient = ingredient.replacingOccurrences(of: "&#0174;", with: "®")
            
            let words = tempIngredient.components(separatedBy: " ")

            
            var wordIsRepeated = true
            if words.count > 1{
                for i in 0...(words.count/2)-1{
                    if words[i] != words[i + words.count / 2]{
                        wordIsRepeated = false
                        break
                    }
                }
            }
            

            if wordIsRepeated{
                tempIngredient = words[0...words.count/2].joined(separator: " ")
            }
            
            if (tempIngredient.characters.last != ":" &&
                tempIngredient.characters.last != ";" &&
                tempIngredient.characters.last != "_" &&
                tempIngredient.characters.first != "&" ){ // Bullshit dividers that get read in as ingredients, this might need to be expanded
                newIngredientList.append(tempIngredient)
            }

        }
        return newIngredientList
        
    }
    
    func addItemToCustomRecipe(item: String){
        self.customItemsRecipe.ingredients.append(item)
        self.saveCustomIngredientsRecipe()
    }
    
    func removeItemFromCustomRecipe(index: Int){
        //self.customItemsRecipe.ingredients.remove(at: index)
        self.saveCustomIngredientsRecipe() 
    }
    
    
    func saveCustomIngredientsRecipe()
    {
        NSKeyedArchiver.archiveRootObject(self.customItemsRecipe, toFile: customRecipeFilePath)
    }
    
    func loadCustomRecipeFromDisk(){
        if let recipe = NSKeyedUnarchiver.unarchiveObject(withFile: customRecipeFilePath) as? Recipe {
            self.customItemsRecipe = recipe
        }
        else{
            self.customItemsRecipe = Recipe(new_f2f_url: "NONE", new_publisher: "NONE", new_recipe_id: "NONE", new_social_rank: 00.00, new_publisher_url: "NONE", new_source_url: "NONE", new_title: "Other", new_image_url: "NONE", new_saved: false, new_carted: false, new_image: UIImage() , new_ingredients: [String]())
        }
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
        
        for alreadyIncludedRecipe in savedRecipes{
            if alreadyIncludedRecipe.recipe_id == recipe.recipe_id{
                self.saveRecipesToDisk()
                return
            }
        }
        
        if recipe.ingredients == nil || recipe.ingredients.count == 0{
            self.setIngredients(recipe: recipe)
        }
        
        self.savedRecipes.append(recipe)
        self.saveRecipesToDisk()
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



