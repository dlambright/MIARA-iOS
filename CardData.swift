//
//  CardData.swift
//  Miara
//
//  Created by Charlie Buckets on 1/3/17.
//  Copyright © 2017 ChalieBuckets. All rights reserved.
//

import UIKit

class CardData: NSObject {
    var ingredient : String!
    var instruction : String!
    var rangeHigh : Int!
    var rangeLow : Int!
    
    init(newIngredient : String, newInstruction : String, newRangeLow : Int, newRangeHigh : Int){
        super.init()
        self.ingredient = newIngredient
        self.instruction = newInstruction
        self.rangeLow = newRangeLow
        self.rangeHigh = newRangeHigh
    }
    
}
