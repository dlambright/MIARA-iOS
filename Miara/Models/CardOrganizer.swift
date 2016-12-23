//
//  CardOrganizer.swift
//  Miara
//
//  Created by Charlie Buckets on 12/21/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class CardOrganizer: NSObject {
    
    
    
    func getDirectionsList(url: String)->[String]{
        var recipeHtml : String!
        //make url request
        
        if let url = URL(string: url) {
            do {
                recipeHtml = try String(contentsOf: url)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        
        
        print (recipeHtml)
        
        
        
        //find the directions table
        
        
        
        return ["Dustin", "Lambright"]
    }

}
