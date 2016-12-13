//
//  SearchResultsViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 12/8/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var lblTitle: UILabel!
    var recipeList = [Recipe]()
    var selectedRecipe : Recipe?
    @IBOutlet var tblSearchResults: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        lblTitle.text = "search results"

        // Do any additional setup after loading the view.
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
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        
        cell.lblTitle.text = recipeList[indexPath.row].title
        cell.imgRecipeView.image = recipeList[indexPath.row].image
        
        cell.lblRating.text = String(Int(recipeList[indexPath.row].social_rank))
        cell.recipe = recipeList[indexPath.row]
        //cell.viewBackground.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecipeTableViewCell
        selectedRecipe = cell.recipe
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recipeDetailViewController") as? RecipeDetailViewController{ //as? HomePageViewController{
            
            vc.currentRecipe = selectedRecipe
            //present(vc, animated: true, completion: nil)
            tblSearchResults.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        //self.navigationItem.
        //self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController")
        //self.performSegue(withIdentifier: "tableToDetailSegue", sender: nil)
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
