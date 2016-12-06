//
//  RecipeTableViewCell.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/24/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgRecipeView: UIImageView!
    var recipe : Recipe! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
