//
//  CardData.swift
//  Miara
//
//  Created by Charlie Buckets on 12/23/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class CardData: NSObject {
    var ingredient : String!
    var instruction : String!
    
    init(newIngredient : String, newInstruction : String){
        super.init()
        self.ingredient = newIngredient
        self.instruction = newInstruction
    }
    
}
