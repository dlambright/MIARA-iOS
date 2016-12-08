//
//  SearchResultTableViewTableViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/24/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class SearchResultTableViewTableViewController: UITableViewController {
    var recipeList = [Recipe]()
    var selectedRecipe : Recipe?
    
    let colors = [UIColor(colorLiteralRed: 232/255, green: 62/255, blue: 185/255, alpha: 0.85),
                  UIColor(colorLiteralRed: 255/255, green: 168/255, blue: 68/255, alpha: 0.85),
                  UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.85),
                  UIColor(colorLiteralRed: 32/232, green: 232/255, blue: 109/255, alpha: 0.85),
                  UIColor(colorLiteralRed: 255/255, green: 239/255, blue: 75/255, alpha: 0.85)]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*var recipeThree = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: 12, new_social_rank: 90, new_publisher_url: "qw", new_source_url: "zx", new_title: "some stuff", new_image_url: "http://static.food2fork.com/Strawberry2BBalsamic2BPizza2Bwith2BChicken252C2BSweet2BOnion2Band2BSmoked2BBacon2B5002B300939d125e2.jpg")
        let recipeFour = Recipe(new_f2f_url: "yolo", new_publisher: "dustin", new_recipe_id: 21, new_social_rank: 100, new_publisher_url: "yoyo", new_source_url: "wer", new_title: "stuff", new_image_url: "http://static.food2fork.com/avocadopizzawithcilantrosauce4bf5.jpg")
        let recipeTwo = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: 12, new_social_rank: 90, new_publisher_url: "qw", new_source_url: "zx", new_title: "fite me irl", new_image_url: "http://static.food2fork.com/Strawberry2BBalsamic2BPizza2Bwith2BChicken252C2BSweet2BOnion2Band2BSmoked2BBacon2B5002B300939d125e2.jpg")
        
        recipeList.append(recipeTwo)
        recipeList.append(recipeThree)
        recipeList.append(recipeFour)*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCellIdentifier", for: indexPath) as! RecipeTableViewCell

        cell.lblTitle.text = recipeList[indexPath.row].title
        cell.imgRecipeView.image = recipeList[indexPath.row].image
        cell.recipe = recipeList[indexPath.row]
        cell.viewBackground.backgroundColor = colors[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecipeTableViewCell
        selectedRecipe = cell.recipe
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recipeDetailViewController") as? RecipeDetailViewController{ //as? HomePageViewController{
            
            vc.currentRecipe = selectedRecipe
            //present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        //self.navigationItem.
        //self.storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController")
        //self.performSegue(withIdentifier: "tableToDetailSegue", sender: nil)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let newVC = segue.destination as! RecipeDetailViewController
        newVC.currentRecipe = selectedRecipe
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
