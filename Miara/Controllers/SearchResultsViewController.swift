//
//  SearchResultsViewController.swift
//  Miara
//
//  Created by Charlie Buckets on 12/8/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var lblTitle: UILabel!
    //var recipeList = [Recipe]()
    var selectedRecipe : Recipe?
    var searchTerm : String!
    @IBOutlet var tblSearchResults: UITableView!
    
    init(_ coder: NSCoder? = nil) {
        
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    
    required convenience init(coder: NSCoder) {
        self.init(coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        lblTitle.text = searchTerm

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tblSearchResults.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance.recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
                
        if (Model.sharedInstance.recipeList[indexPath.row].image != nil){
            cell.imgRecipeView.image = Model.sharedInstance.recipeList[indexPath.row].image
        }
        
        cell.lblTitle.text = Model.sharedInstance.recipeList[indexPath.row].title
        cell.lblRating.text = String(Int(Model.sharedInstance.recipeList[indexPath.row].social_rank))
        cell.recipe = Model.sharedInstance.recipeList[indexPath.row]
        cell.toggleSavedColoring()          
        //cell.viewBackground.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecipeTableViewCell
        selectedRecipe = cell.recipe
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recipeDetailViewController") as? RecipeDetailViewController{
            
            if (selectedRecipe?.ingredients == nil || selectedRecipe?.ingredients.count == 0){
                Model.sharedInstance.getIngredientsForRecipeWithId(id: (selectedRecipe?.recipe_id)!)
                sleep(1)
            }
            
            tblSearchResults.deselectRow(at: indexPath, animated: true)
            vc.currentRecipe = selectedRecipe
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
