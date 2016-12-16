//
//  RecipeTableViewCell.swift
//  EZRecipe
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

        if (viewBackground.backgroundColor == UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.70)){
            viewBackground.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        }
        else{
            viewBackground.backgroundColor = UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.70)
        }
    }

}
