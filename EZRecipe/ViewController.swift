//
//  ViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/13/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//
// background http://more-sky.com/WDF-29504.html

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnSavedRecipes: UIButton!    
    @IBOutlet var txtSearchText: UITextField!

    
    var recipeThree = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: "12", new_social_rank: 100, new_publisher_url: "qw", new_source_url: "http://thepioneerwoman.com/cooking/cinammon_rolls_/", new_title: "pizza", new_image_url: "http://static.food2fork.com/4364270576_302751a2a4f3c1.jpg")
    let recipeFour = Recipe(new_f2f_url: "yolo", new_publisher: "dustin", new_recipe_id: "21", new_social_rank: 77.7, new_publisher_url: "yoyo", new_source_url: "http://www.closetcooking.com/2011/08/buffalo-chicken-grilled-cheese-sandwich.html", new_title: "peetz", new_image_url: "http://static.food2fork.com/avocadopizzawithcilantrosauce4bf5.jpg")
    let recipeTwo = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: "12", new_social_rank: 50, new_publisher_url: "qw", new_source_url: "http://www.seriouseats.com/2016/03/peepshi-sushi-easter-marshmallow-peeps-how-to.html" , new_title: "za", new_image_url: "http://static.food2fork.com/Strawberry2BBalsamic2BPizza2Bwith2BChicken252C2BSweet2BOnion2Band2BSmoked2BBacon2B5002B300939d125e2.jpg")
    let recipeOne = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: "12", new_social_rank: 1, new_publisher_url: "qw", new_source_url: "http://www.bbcgoodfood.com/recipes/873655/cookie-monster-cupcakes" , new_title: "pizza again", new_image_url: "http://static.food2fork.com/Taco2BQuesadilla2BPizza2B5002B4417a4755e35.jpg")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearchText.text = "taco"
        


        // Create action to dismiss keyboard when clicked outside of keyboard touch area
        // and added tap gesture to view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
//        recipeOne.ingredients = ["1 cup sugar", "2 cups flour", "1 tsp dank memes"]
//        recipeTwo.ingredients = ["1 cup sugar", "2 cups flour", "1 tsp dank memes"]
//        recipeThree.ingredients = ["1 cup sugar", "2 cups flour", "1 tsp dank memes"]
//        recipeFour.ingredients = ["1 cup sugar", "2 cups flour", "1 tsp dank memes"]
//        Model.sharedInstance.recipeList.append(recipeOne)
//        Model.sharedInstance.recipeList.append(recipeTwo)
//        Model.sharedInstance.recipeList.append(recipeThree)
//        Model.sharedInstance.recipeList.append(recipeFour)
        btnSearch.layer.borderColor = UIColor.white.cgColor
        btnSavedRecipes.layer.borderColor = UIColor.white.cgColor
        
        ///self.makeHTTPRequest()
        
        
    }
    
    // Function to dismiss keyboard
    func dismissKeyboard() {
        view.endEditing(true);
    }
    
    @IBAction func btnSearchPress(_ sender: Any) {
        let searchTerm = txtSearchText.text
        
        if (searchTerm != ""){
            Model.sharedInstance.searchRecipesWithString(searchString: searchTerm!)
            
            for _ in 0...2{
                if(Model.sharedInstance.recipeList.count > 0){
                    sleep(1)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let srvc = storyboard.instantiateViewController(withIdentifier: "searchResultsViewController") as! SearchResultsViewController
                    srvc.searchTerm = "search results for \"" + searchTerm! + "\""
                    if let navigator = navigationController {
                        navigator.pushViewController(srvc, animated: true)
                    }
                    return
                }
                else{
                    sleep(1)
                }
            }
            
            // If nothing get s returned from the server, send an error message
            let alert = UIAlertController(title: "", message: "Unable to retrieve data from server", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let newViewController = segue.destination as! SearchResultsViewController
//        newViewController.recipeList = self.recipeList
        //newViewController.lblTitle.text = "search results for dank pizza"
   // }
    
    


}

