//
//  Recipe.swift
//  Miara
//
//  Created by Charlie Buckets on 11/13/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import SwiftyJSON

class Recipe: NSObject, NSCoding {
    
    struct Keys {
        static let F2f_url = "f2f_url"
        static let Publisher = "publisher"
        static let Recipe_id = "recipe_id"
        static let Social_rank = "social_rank"
        static let Publisher_url = "publisher_url"
        static let Source_url = "source_url"
        static let Title = "title"
        static let Image_url = "image_url"
        static let Image = "image"
        static let Saved = "saved"
        static let Carted = "carted"
        static let Ingredients = "ingredients"
    }
    
    
    var f2f_url : String!
    var publisher : String!
    var recipe_id : String!
    var social_rank : Double!
    var publisher_url : String!
    var source_url : String!
    var title : String!
    var image_url : String!
    var image : UIImage!
    var saved : Bool!
    var carted: Bool!
    var ingredients : [String]!
    
    init(name: String){
        super.init()
        self.title = name
        self.ingredients = [String]()
    }
    
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
        self.publisher = new_publisher
        self.recipe_id = new_recipe_id
        self.social_rank = new_social_rank
        self.publisher_url = new_publisher_url
        self.source_url = new_source_url
        self.title = self.cleanString(string: new_title)
        self.image_url =  new_image_url
        self.saved = false
        self.carted = false
        
        DispatchQueue.global(qos: .background).async {
            self.setActualImage()
        }
    }
    
    
    init(new_f2f_url : String,
         new_publisher : String,
         new_recipe_id : String,
         new_social_rank : Double,
         new_publisher_url : String,
         new_source_url : String,
         new_title : String,
         new_image_url : String,
         new_saved : Bool,
         new_carted : Bool,
         new_image : UIImage,
         new_ingredients : [String]){
        super.init()
        self.f2f_url = new_f2f_url
        self.publisher = new_publisher
        self.recipe_id = new_recipe_id
        self.social_rank = new_social_rank
        self.publisher_url = new_publisher_url
        self.source_url = new_source_url
        self.title = cleanString(string: new_title)
        self.image_url =  new_image_url
        self.saved = new_saved
        self.carted = new_carted
        self.image = new_image
        self.ingredients = new_ingredients
    }
    
    required init(newJson: JSON){
        super.init()
        self.f2f_url = newJson["f2f_url"].stringValue
        self.publisher = newJson["publisher"].stringValue
        self.recipe_id = newJson["recipe_id"].stringValue
        self.social_rank = newJson["social_rank"].doubleValue
        self.publisher_url = newJson["publisher_url"].stringValue
        self.source_url = newJson["source_url"].stringValue
        self.title = self.cleanString(string: newJson["title"].stringValue)
        self.image_url =  newJson["image_url"].stringValue
        self.saved = false
        self.carted = false
        let ingreds = newJson["ingredients"].arrayObject as! [String]!
        if ingreds != nil && ingreds!.count > 0{
            self.ingredients = Model.sharedInstance.sanitizeIngredientsList(ingredientsToTest: ingreds!)
        }
        DispatchQueue.global(qos: .background).async {
            self.setActualImage()
        }

    }  

    
    func setActualImage(){
        let url = URL(string: self.image_url)
        
            DispatchQueue.global(qos: .background).async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                
                if (data != nil){
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data!)
                    }
                }
            }

    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(f2f_url, forKey: Keys.F2f_url)
        aCoder.encode(publisher, forKey: Keys.Publisher)
        aCoder.encode(recipe_id, forKey: Keys.Recipe_id)
        aCoder.encode(social_rank, forKey: Keys.Social_rank)
        aCoder.encode(publisher_url, forKey: Keys.Publisher_url)
        aCoder.encode(source_url, forKey: Keys.Source_url)
        aCoder.encode(title, forKey: Keys.Title)
        aCoder.encode(image_url, forKey: Keys.Image_url)
        aCoder.encode(image, forKey: Keys.Image)
        aCoder.encode(saved, forKey: Keys.Saved)
        aCoder.encode(carted, forKey: Keys.Carted)        
        
        if ingredients != nil{
            aCoder.encode(ingredients, forKey: Keys.Ingredients)
        } 
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        ///super.init()
        

        let f2f_url = aDecoder.decodeObject(forKey: Keys.F2f_url) as! String
        let publisher = aDecoder.decodeObject(forKey: Keys.Publisher) as! String
        let recipe_id = aDecoder.decodeObject(forKey: Keys.Recipe_id) as! String
        let social_rank = aDecoder.decodeObject(forKey: Keys.Social_rank) as! Double
        let publisher_url = aDecoder.decodeObject(forKey: Keys.Publisher_url) as! String
        let source_url = aDecoder.decodeObject(forKey: Keys.Source_url) as! String
        let title = aDecoder.decodeObject(forKey: Keys.Title) as! String
        let image_url = aDecoder.decodeObject(forKey: Keys.Image_url) as! String
        let image = aDecoder.decodeObject(forKey: Keys.Image) as! UIImage
        let saved = aDecoder.decodeObject(forKey: Keys.Saved) as! Bool
        let carted = aDecoder.decodeObject(forKey: Keys.Carted) as! Bool
        var ingredients = [String]()
        if (aDecoder.containsValue(forKey: Keys.Ingredients)){
           ingredients = (aDecoder.decodeObject(forKey: Keys.Ingredients) as? [String])!
        }
        self.init(new_f2f_url : f2f_url,
                  new_publisher : publisher,
                  new_recipe_id : recipe_id,
                  new_social_rank : social_rank,
                  new_publisher_url : publisher_url,
                  new_source_url : source_url,
                  new_title : title,
                  new_image_url : image_url,
                  new_saved : saved,
                  new_carted : carted,
                  new_image : image,
                  new_ingredients : ingredients)
        
        self.title = cleanString(string: self.title)
        
    }
    
    func cleanString(string: String)->String{
        var newString = string.replacingOccurrences(of: "&amp;", with: "&")
        newString = newString.replacingOccurrences(of: "&#8217;", with: "'")
        return newString
    }
}
