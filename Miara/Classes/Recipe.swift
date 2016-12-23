//
//  Recipe.swift
//  Miara
//
//  Created by Charlie Buckets on 11/13/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import SwiftyJSON

class Recipe: NSObject {
    var f2f_url : String!
    var publiser : String!
    var recipe_id : String!
    var social_rank : Double!
    var publisher_url : String!
    var source_url : String!
    var title : String!
    var image_url : String!
    var image : UIImage!
    var saved : Bool!
    var ingredients : [String]!
    
    
    init(new_f2f_url : String,
         new_publisher : String,
         new_recipe_id : String,
         new_social_rank : Double,
         new_publisher_url : String,
         new_source_url : String,
         new_title : String,
         new_image_url : String){
        super.init()
        self.f2f_url = new_f2f_url
        self.publiser = new_publisher
        self.recipe_id = new_recipe_id
        self.social_rank = new_social_rank
        self.publisher_url = new_publisher_url
        self.source_url = new_source_url
        self.title = new_title
        self.image_url =  new_image_url
        self.setActualImage()
    }
    
    required init(newJson: JSON){
        super.init()
        self.f2f_url = newJson["f2f_url"].stringValue
        self.publiser = newJson["publisher"].stringValue
        self.recipe_id = newJson["recipe_id"].stringValue
        self.social_rank = newJson["social_rank"].doubleValue
        self.publisher_url = newJson["publisher_url"].stringValue
        self.source_url = newJson["source_url"].stringValue
        self.title = newJson["title"].stringValue
        self.image_url =  newJson["image_url"].stringValue
        self.ingredients = newJson["ingredients"].arrayObject as! [String]!
        self.setActualImage()
    }
    
    func setActualImage(){
        let url = URL(string: self.image_url)
        
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                
                if (data != nil){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data!)
                    }
                }
            }

    }

}
