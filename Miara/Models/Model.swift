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
                        let newRecipe:Recipe = Recipe(newJson: recipeArray[i])
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
                ingredients = swiftyJson["recipe"]["ingredients"].arrayObject as! [String]!
                
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
    
    private func saveRecipesToDisk(){
        NSKeyedArchiver.archiveRootObject(self.savedRecipes, toFile: recipeFilePath)
    }
    
    func loadRecipesFromDisk(){
        if let array = NSKeyedUnarchiver.unarchiveObject(withFile: recipeFilePath) as? [Recipe] {
            self.savedRecipes = array
        }
    }
    
    
    func saveRecipe(recipe: Recipe){
        self.savedRecipes.append(recipe)
        saveRecipesToDisk()
    }
    
    func removeSavedRecipe(recipe: Recipe){
        for listRecipe in recipeList{
            if (listRecipe.recipe_id == recipe.recipe_id){
                listRecipe.saved = false
            }
        }
        var toDeleteArray = [Int]()
        for i in 0...savedRecipes.count-1{
            if (savedRecipes[i].recipe_id == recipe.recipe_id){
                toDeleteArray.append(savedRecipes.count-1-i)
            }
        }
        
        if (toDeleteArray.count > 0){
            for i in 0...toDeleteArray.count-1{
                savedRecipes.remove(at: toDeleteArray[i])
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
    

}
















