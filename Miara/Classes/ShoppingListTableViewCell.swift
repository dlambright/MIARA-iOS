//
//  ShoppingListTableViewCell.swift
//  Miara
//
//  Created by Charlie Buckets on 1/9/17.
//  Copyright © 2017 ChalieBuckets. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet var lblIngredient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
