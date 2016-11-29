//
//  ViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/13/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    let basicUrl = "http://www.food2fork.com/api/search?key=c042b0a932dea3455a4f91097140f8c9&q=pizza"
    var recipeList = [Recipe]()
    //let basicUrl = "http://www.google.com"
    
    let recipeThree = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: 12, new_social_rank: 90, new_publisher_url: "qw", new_source_url: "zx", new_title: "some stuff", new_image_url: "http://static.food2fork.com/4364270576_302751a2a4f3c1.jpg")
    let recipeFour = Recipe(new_f2f_url: "yolo", new_publisher: "dustin", new_recipe_id: 21, new_social_rank: 100, new_publisher_url: "yoyo", new_source_url: "wer", new_title: "stuff", new_image_url: "http://static.food2fork.com/avocadopizzawithcilantrosauce4bf5.jpg")
    let recipeTwo = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: 12, new_social_rank: 90, new_publisher_url: "qw", new_source_url: "zx", new_title: "fite me irl", new_image_url: "http://static.food2fork.com/Strawberry2BBalsamic2BPizza2Bwith2BChicken252C2BSweet2BOnion2Band2BSmoked2BBacon2B5002B300939d125e2.jpg")
    let recipeOne = Recipe(new_f2f_url: "no", new_publisher: "no", new_recipe_id: 12, new_social_rank: 90, new_publisher_url: "qw", new_source_url: "zx", new_title: "new stuffz", new_image_url: "http://static.food2fork.com/Taco2BQuesadilla2BPizza2B5002B4417a4755e35.jpg")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeList.append(recipeOne)
        recipeList.append(recipeTwo)
        recipeList.append(recipeThree)
        recipeList.append(recipeFour)
        
        //self.makeHTTPRequest()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    func makeHTTPRequest(){

        recipeList = [Recipe]()
        let eurl = URL(string: basicUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!
        
        let request = URLRequest(url: eurl)
        //request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            if let jsonData = data {
                
                let swiftyJson:JSON = JSON(data: jsonData)
                let count = swiftyJson["count"].intValue
                let recipeArray = swiftyJson["recipes"].arrayValue
                
                for i in (0...count-1){
                    let newRecipe:Recipe = Recipe(newJson: recipeArray[i])
                    self.recipeList.append(newRecipe)
                }
                print(count)
                
                let yolo:String = String(describing: data)
                print(yolo)
                
                }
            print("Entered the completionHandler")
            }.resume()
        

    }
    
    func readSampleText(){
        let swiftyJson:JSON = JSON(sampleResult)
        let count = swiftyJson["count"].intValue
        let recipeArray = swiftyJson["recipes"].arrayValue
        
        for i in (0...count-1){
            let newRecipe:Recipe = Recipe(newJson: recipeArray[i])
            self.recipeList.append(newRecipe)
            
//            let url = URL(string: image.url)
//            
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async {
//                    imageView.image = UIImage(data: data!)
//                }
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newViewController = segue.destination as! SearchResultTableViewTableViewController
        newViewController.recipeList = self.recipeList
    }
    
    


}

