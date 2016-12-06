//
//  RecipeDetailViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/26/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//


//LOOK INTO THIS CLASS DUSTIN
//https://github.com/zhxnlai/ZLSwipeableViewSwift


import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet var lblRecipeTitle: UILabel!
    @IBOutlet var imgFoodImage: UIImageView!
    
    var currentRecipe : Recipe! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFoodImage.image = currentRecipe.image
        lblRecipeTitle.text = currentRecipe.title

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as? RecipeWebViewViewController
        
        vc?.urlString = currentRecipe.source_url
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    


}
