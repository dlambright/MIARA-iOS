//
//  RecipeDetailViewController.swift
//  Miara
//
//  Created by Charlie Buckets on 11/26/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//


//LOOK INTO THIS CLASS DUSTIN
//https://github.com/zhxnlai/ZLSwipeableViewSwift


import UIKit
import MDCSwipeToChoose
import SwiftyJSON

enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
}


class RecipeDetailViewController: UIViewController, MDCSwipeToChooseDelegate {

    @IBOutlet var viewCardViewHolder: UIView!
    @IBOutlet var btnLink: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnCards: UIButton!
    @IBOutlet var btnCart: UIButton!
    @IBOutlet var lblRecipeTitle: UILabel!
    @IBOutlet var imgFoodImage: UIImageView!
    @IBOutlet var txtIngredientDetail: UITextView!
    @IBOutlet var actCardindicator: UIActivityIndicatorView!
    
    var cardData = [CardData]()
    var cardOrganizer = CardOrganizer()
    
    
    var currentRecipe : Recipe! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (currentRecipe.image != nil){
            imgFoodImage.image = currentRecipe.image
        }
        lblRecipeTitle.text = currentRecipe.title
        
        if currentRecipe.saved == true{
            btnSave.backgroundColor = UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.25)
        }
        
        if currentRecipe.carted == true{
            btnCart.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 231/255, blue: 93/255, alpha: 0.25)
        }
        
        self.btnCards.isEnabled = false
        self.btnCards.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.05)

        self.adjustMargins()

        
        DispatchQueue.global(qos: .background).async {
            
            if (self.currentRecipe.ingredients == nil ||
                self.currentRecipe.ingredients.count == 0 ||
                self.currentRecipe.source_url.contains("tastykitchen.com")){
                self.setIngredientsForCurrentRecipe()
            }
            for _ in 0...15{

                if (self.currentRecipe.ingredients != nil && self.currentRecipe.source_url != nil){
                    self.cardData = self.cardOrganizer.getCardDictionary(ingredientList: self.currentRecipe.ingredients, instructionURL: self.currentRecipe.source_url)
                    break
                }
                sleep(1)
            }
            
            DispatchQueue.main.async {
                self.actCardindicator.stopAnimating()
                if (self.cardData.count > 0){
                    self.btnCards.isEnabled = true
                    self.btnCards.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.25)
                    //self.btnCards.imageView?.image = UIImage(named: "card_stack.png")
                    //self.btnCards.titleLabel?.text = ""
                }
                else{
                    self.btnCards.isHidden = true
                }
            }
            
        }
    }
    
    func refreshCardStack(startingIndex: Int){
        
        for view in viewCardViewHolder.subviews {
            if view is MDCSwipeToChooseView {
                view.removeFromSuperview()
            }
        }
        
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
                options.likedText = ""
                options.likedColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0) // hacky way to not have the liked/disliked boxes on the cards
                options.nopeText = ""
                options.nopeColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0) // hacky way to not have the liked/disliked boxes on the cards
        options.onPan = { state -> Void in
            if state?.thresholdRatio == 1 && state?.direction == MDCSwipeDirection.left {
                //print("Photo deleted!")
            }
        }
        if (currentRecipe.ingredients == nil ||
            currentRecipe.ingredients.count == 0){
            currentRecipe.ingredients = ["1 cup sugar", "2 cups flour", "1 tsp dank memes"]
        }
        for i in startingIndex...cardData.count-1{
            let newCardView = MDCSwipeToChooseView(frame: CGRect(x : 0, y : 0 , width : viewCardViewHolder.frame.width, height: viewCardViewHolder.frame.height) , options: options)!
            newCardView.layer.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
            
            let lblItemName = UILabel(frame: CGRect(x: 8, y: 0, width: newCardView.layer.frame.width-16, height: 60))
            lblItemName.font = UIFont(name: "Arial Rounded MT Bold", size: 20.0)
            lblItemName.textColor = UIColor.black
            lblItemName.layer.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0).cgColor
            lblItemName.text = cardData[cardData.count-i-1+startingIndex].ingredient  // all weird becuase it needs to be read backward
            lblItemName.textAlignment = NSTextAlignment.center
            lblItemName.lineBreakMode = NSLineBreakMode.byWordWrapping
            lblItemName.numberOfLines = 0
            
            newCardView.addSubview(lblItemName)
            NSLayoutConstraint(item: lblItemName, attribute: .trailing, relatedBy: .equal, toItem: newCardView, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
            
            let viewRedLine = UIView(frame: CGRect(x: 0, y: lblItemName.frame.height, width: newCardView.layer.frame.width, height: 1))
            viewRedLine.layer.backgroundColor = UIColor(colorLiteralRed: 113/255, green: 50/255, blue: 93/255, alpha: 1).cgColor
            newCardView.addSubview(viewRedLine)

            
            
            let lblItemStep = UILabel(frame: CGRect(x: 16, y: viewRedLine.frame.height + lblItemName.frame.height  + 16, width: newCardView.layer.frame.width - 32, height: newCardView.frame.height - lblItemName.frame.height - viewRedLine.frame.height - 32))
            
            lblItemStep.font = UIFont(name: "Arial Rounded MT Bold", size: 15.0)
            
            let ttext = cardData[cardData.count-i-1+startingIndex].instruction
            let range = NSMakeRange(cardData[cardData.count-i-1+startingIndex].rangeLow, cardData[cardData.count-i-1+startingIndex].rangeHigh - cardData[cardData.count-i-1+startingIndex].rangeLow)
            let attributedString = NSMutableAttributedString(string:ttext!)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(colorLiteralRed: 113/255, green: 50/255, blue: 93/255, alpha: 1) , range: range)
            attributedString.addAttribute(NSFontAttributeName, value: UIFont(
                name: "Arial Rounded MT Bold",size: 25.0)!, range: range)
            
            lblItemStep.attributedText = attributedString
            
            lblItemName.lineBreakMode = NSLineBreakMode.byWordWrapping
            lblItemStep.numberOfLines = 0
            newCardView.addSubview(lblItemStep)
            lblItemStep.sizeToFit()
            
            self.viewCardViewHolder.addSubview(newCardView)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //refreshCardStack()
        self.refreshIngredientsList()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as? RecipeWebViewViewController
        
        vc?.urlString = currentRecipe.source_url
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void{
        //print("Couldn't decide, huh?")
    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(_ view: UIView, shouldBeChosenWith shouldBeChosenWithDirection: MDCSwipeDirection) -> Bool{
        if (shouldBeChosenWithDirection == MDCSwipeDirection.left) {
            return true;
        } else {
            // Snap the view back and cancel the choice.
            
            UIView.animate(withDuration: 0.16, animations:  { () -> Void in
                view.transform = CGAffineTransform.identity
                view.center = view.superview!.center
            })
            
            return false;
        }
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) -> Void{

    }

    @IBAction func refreshPress(_ sender: Any) {

        refreshCardStack(startingIndex: 0)
        
    }
    
    @IBAction func btnSaveTouch(_ sender: UIButton) {
        if (currentRecipe.saved == true){
            btnSave.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
            currentRecipe.saved = false
            
            btnCart.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
            currentRecipe.carted = false
        }
        else{
            btnSave.backgroundColor = UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.25)
            currentRecipe.saved = true
            Model.sharedInstance.saveRecipe(recipe: currentRecipe)
        }
    }
    
    @IBAction func btnCartTouch(_ sender: UIButton) {
        if (currentRecipe.carted == true){
            btnCart.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
            currentRecipe.carted = false
        }
        else{
            btnSave.backgroundColor = UIColor(colorLiteralRed: 68/255, green: 111/255, blue: 255/255, alpha: 0.25)
            currentRecipe.saved = true
            
            btnCart.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 231/255, blue: 93/255, alpha: 0.25)
            currentRecipe.carted = true
            
            Model.sharedInstance.saveRecipe(recipe: currentRecipe)
            
        }
        
    }
    
    func setIngredientsForCurrentRecipe(){
//        DispatchQueue.main.async{
            if(self.currentRecipe.source_url.contains("tastykitchen.com/")){
                self.currentRecipe.ingredients = Model.sharedInstance.getIngredientsFromTastyKitchen(url: self.currentRecipe.source_url)
                Model.sharedInstance.setIngredientsForRecipeWithId(id: self.currentRecipe.recipe_id, ingredients: self.currentRecipe.ingredients)
                self.refreshIngredientsList()
            }
            else{
                Model.sharedInstance.getIngredientsForRecipeWithId(id: self.currentRecipe.recipe_id, callback: { (data) in
                let jsonData = data
                let swiftyJson:JSON = JSON(data: jsonData as Data)
                let ingredients = Model.sharedInstance.sanitizeIngredientsList(ingredientsToTest: swiftyJson["recipe"]["ingredients"].arrayObject as! [String]!)
                Model.sharedInstance.setIngredientsForRecipeWithId(id: self.currentRecipe.recipe_id, ingredients: ingredients)
                self.currentRecipe.ingredients = ingredients
                self.refreshIngredientsList()
                })
            }
//        }
    }

    func refreshIngredientsList(){
        DispatchQueue.main.async {
            /* Do UI work here */
            
            if (self.currentRecipe.ingredients == nil || self.currentRecipe.ingredients.count == 0){
                self.txtIngredientDetail.text = "missing ingredients....try again"
            }
            else{
                self.txtIngredientDetail.text = ""
                for ingredient in self.currentRecipe.ingredients{
                    self.txtIngredientDetail.text = self.txtIngredientDetail.text! + ingredient + "\n"
                }
            }
        }
    }
    
    func adjustMargins(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            var landscape = 0
            if UIDevice.current.orientation.isLandscape == true{
                
                if UIScreen.main.bounds.size.width == 1366{
                    landscape = 70
                }
                else{
                    landscape = 40
                }
            }
            else if UIScreen.main.bounds.size.width == 1024{
                landscape = 30
            }
            
            let insetHeight = CGFloat(4) // To determine the size of the insets
            let insetWidth = CGFloat(50 + landscape)
            let uiEdgeInsets = UIEdgeInsetsMake(insetHeight, insetWidth, insetHeight, insetWidth)
            btnLink.contentEdgeInsets = uiEdgeInsets
            btnCards.contentEdgeInsets = uiEdgeInsets
            btnCart.contentEdgeInsets = uiEdgeInsets
            btnSave.contentEdgeInsets = uiEdgeInsets
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.adjustMargins()
        
        DispatchQueue.main.async{
            self.refreshCardStack(startingIndex: (self.cardData.count - self.viewCardViewHolder.subviews.count + 1)) // already 2 subviews in cardDataHolder
//            for view in self.viewCardViewHolder.subviews{
//                view.frame.size = self.viewCardViewHolder.frame.size
                //            view.frame.width = self.viewCardViewHolder.frame.width
                //            view.frame.height = self.viewCardViewHolder.frame.height
//            }
        
        }
    }
}











