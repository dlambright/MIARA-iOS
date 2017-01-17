//
//  ViewController.swift
//  Miara
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
    @IBOutlet var btnShoppingList: UIButton!
    @IBOutlet var txtSearchText: UITextField!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSearch.layer.borderColor = UIColor.white.cgColor
        btnSavedRecipes.layer.borderColor = UIColor.white.cgColor
        btnShoppingList.layer.borderColor = UIColor.white.cgColor
        Model.sharedInstance.loadRecipesFromDisk()
        
        txtSearchText.text = "taco"
        //Model.sharedInstance.nukeAllRecipes()
        
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
    

    @IBAction func btnSavedRecipesPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let srvc = storyboard.instantiateViewController(withIdentifier: "searchResultsViewController") as! SearchResultsViewController
        srvc.searchTerm = "my saved recipes"
        if let navigator = navigationController {
            Model.sharedInstance.setSavedRecipesToCurrentRecipes()
            navigator.pushViewController(srvc, animated: true)
        }
        return
    }
    
    @IBAction func btnShoppingLIstPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let slvc = storyboard.instantiateViewController(withIdentifier: "shoppingListViewController") as! ShoppingListTableViewController
        if let navigator = navigationController {
            Model.sharedInstance.setCartedRecipesToCurrentRecipes()
            navigator.pushViewController(slvc, animated: true)
        }
        return
        
    }

}

