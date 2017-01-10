//
//  RecipeTableViewCell.swift
//  Miara
//
//  Created by Charlie Buckets on 11/24/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgRecipeView: UIImageView!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var viewSavedRecipe: UIView!
    @IBOutlet var btnCarted: UIButton!
    @IBOutlet var viewCarted: UIView!
    
    
    
    var recipe : Recipe! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnSavePress(_ sender: Any) {

        if (recipe.saved == true){
            recipe.saved = false
            recipe.carted = false
            Model.sharedInstance.removeSavedRecipe(recipe: recipe)
        }
        else{
            recipe.saved = true
            Model.sharedInstance.saveRecipe(recipe: recipe)
        }
        toggleSavedColoring()
    }
    
    @IBAction func btnCartPress(_ sender: UIButton) {
        
        if (recipe.carted == true){
            recipe.carted = false
            
        }
        else{
            recipe.carted = true
            recipe.saved = true
            
            if recipe.ingredients == nil{
                Model.sharedInstance.getIngredientsForRecipeWithId(id: recipe.recipe_id)
            }
            
            Model.sharedInstance.saveRecipe(recipe: recipe)
        }
        toggleSavedColoring()
    }
    
    
    
    
    
    func toggleSavedColoring(){
        if (recipe.saved == true){
            viewSavedRecipe.backgroundColor = UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.25)

        }
        else{
            viewSavedRecipe.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
        }
        
        if(recipe.carted == true){
            viewCarted.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 231/255, blue: 93/255, alpha: 0.25)
        }
        else{
            viewCarted.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
        }
        
        
        
    }

}
