//
//  SearchResult.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/13/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchResult: NSObject {
    var recipe_array = [String : Recipe]()
    var count : Int!

    required init(newJson: JSON){
        count = newJson["count"].intValue
        recipe_array = newJson["recipes"] as! [String : Recipe]
    }
}
