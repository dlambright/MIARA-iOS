//
//  TempTableViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/25/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class TempTableViewController: UITableViewController {
    var recipeList = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recipeThree = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: 12, new_social_rank: 90, new_publisher_url: "qw", new_source_url: "zx", new_title: "some stuff", new_image_url: "http://static.food2fork.com/Strawberry2BBalsamic2BPizza2Bwith2BChicken252C2BSweet2BOnion2Band2BSmoked2BBacon2B5002B300939d125e2.jpg")
        let recipeFour = Recipe(new_f2f_url: "yolo", new_publisher: "dustin", new_recipe_id: 21, new_social_rank: 100, new_publisher_url: "yoyo", new_source_url: "wer", new_title: "stuff", new_image_url: "http://static.food2fork.com/avocadopizzawithcilantrosauce4bf5.jpg")
        
        recipeList.append(recipeThree)
        recipeList.append(recipeFour)
        let countg = recipeList.count

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
        // #warning Incomplete implementation, return the number of rows
        return recipeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recipeList[indexPath.row].title

        return cell
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
