//
//  ShoppingListTableViewController.swift
//  Miara
//
//  Created by Charlie Buckets on 1/9/17.
//  Copyright © 2017 ChalieBuckets. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    //var ingredientsList = [String]()
    var cartedRecipes = [Recipe]()
    var greenIndices = [[Int]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for recipe in Model.sharedInstance.cartedRecipes{
            if recipe.ingredients != nil{
                cartedRecipes.append(recipe)
            }            
        }
        self.initGreenIndices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cartedRecipes[section].title
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(colorLiteralRed: 113/255, green: 50/255, blue: 93/255, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20.0)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cartedRecipes.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartedRecipes[section].ingredients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListTableViewCell", for: indexPath) as! ShoppingListTableViewCell

        
        //cell.lblIngredient.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0)
        cell.lblIngredient.text = cartedRecipes[indexPath.section].ingredients[indexPath.row]
        
        
        if greenIndices[indexPath.section][indexPath.row] != 0 {
            cell.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 145/255, blue: 63/255, alpha: 1)
            cell.textLabel?.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 145/255, blue: 63/255, alpha: 1)
            
            // change selected color from gray to green
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 145/255, blue: 63/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
        }
        else{
            cell.backgroundColor = UIColor.white
            cell.textLabel?.backgroundColor = UIColor.white
            
            // change selection color from gray to white
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = bgColorView
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ShoppingListTableViewCell
        
        if (cell.backgroundColor == UIColor.white){
            
            cell.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 145/255, blue: 63/255, alpha: 1)
            cell.textLabel?.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 145/255, blue: 63/255, alpha: 1)
            
            // change selected color from gray to green
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(colorLiteralRed: 20/255, green: 145/255, blue: 63/255, alpha: 1)
            cell.selectedBackgroundView = bgColorView
            
            greenIndices[indexPath.section][indexPath.row] = 1
            
        }
        else{
            cell.backgroundColor = UIColor.white
            cell.textLabel?.backgroundColor = UIColor.white
            
            // change selection color from gray to white
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = bgColorView
            greenIndices[indexPath.section][indexPath.row] = 0
            
        }
    }
    
    func initGreenIndices(){
        for i in 0...cartedRecipes.count-1{
            var tempArray = [Int]()
            for _ in 0...cartedRecipes[i].ingredients.count{
                tempArray.append(0)
            }
            greenIndices.append(tempArray)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}