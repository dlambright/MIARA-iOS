//
//  RecipeWebViewViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 12/6/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit

class RecipeWebViewViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    var urlString : String = "www.yahoo.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: urlString);
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
