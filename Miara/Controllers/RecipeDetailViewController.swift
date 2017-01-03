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


class RecipeDetailViewController: UIViewController, MDCSwipeToChooseDelegate {

    @IBOutlet var viewCardViewHolder: UIView!
    @IBOutlet var btnLink: UIButton!
    @IBOutlet var lblRecipeTitle: UILabel!
    @IBOutlet var imgFoodImage: UIImageView!
    var cardData = [CardData]()
    var cardOrganizer = CardOrganizer()
    
    var currentRecipe : Recipe! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (currentRecipe.image != nil){
            imgFoodImage.image = currentRecipe.image
        }
        lblRecipeTitle.text = currentRecipe.title
        
        cardData = cardOrganizer.getCardDictionary(ingredientList: currentRecipe.ingredients, instructionURL: currentRecipe.source_url)
        
    }
    
    func refreshCardStack(){
        
        
        
        
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
        for i in 0...cardData.count-1{
            let newCardView = MDCSwipeToChooseView(frame: CGRect(x : 0, y : 0 , width : viewCardViewHolder.frame.width, height: viewCardViewHolder.frame.height) , options: options)!
            newCardView.layer.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
            
            let lblItemName = UILabel(frame: CGRect(x: 8, y: 0, width: newCardView.layer.frame.width-16, height: 60))
            lblItemName.font = UIFont(name: "Arial Rounded MT Bold", size: 20.0)
            lblItemName.textColor = UIColor.black
            lblItemName.layer.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0).cgColor
            lblItemName.text = cardData[cardData.count-1-i].ingredient  // all weird becuase it needs to be read backward
            lblItemName.textAlignment = NSTextAlignment.center
            lblItemName.lineBreakMode = NSLineBreakMode.byWordWrapping
            lblItemName.numberOfLines = 0
            
            newCardView.addSubview(lblItemName)
            
            let viewRedLine = UIView(frame: CGRect(x: 0, y: lblItemName.frame.height, width: newCardView.layer.frame.width, height: 1))
            viewRedLine.layer.backgroundColor = UIColor(colorLiteralRed: 113/255, green: 50/255, blue: 93/255, alpha: 1).cgColor
            newCardView.addSubview(viewRedLine)
            
            let lblItemStep = UILabel(frame: CGRect(x: 16, y: viewRedLine.frame.height + lblItemName.frame.height  + 16, width: newCardView.layer.frame.width - 32, height: newCardView.frame.height - lblItemName.frame.height - viewRedLine.frame.height - 32))
            
            let ttext = cardData[cardData.count-1-i].instruction
            let range = NSMakeRange(cardData[cardData.count-1-i].rangeLow, cardData[cardData.count-1-i].rangeHigh - cardData[cardData.count-1-i].rangeLow)
            let attributedString = NSMutableAttributedString(string:ttext!)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(colorLiteralRed: 113/255, green: 50/255, blue: 93/255, alpha: 1) , range: range)
            
            lblItemStep.attributedText = attributedString
            lblItemStep.font = UIFont(name: "Arial Rounded MT Bold", size: 14.0)
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
        refreshCardStack()
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
        if wasChosenWithDirection == MDCSwipeDirection.left {
            //print("Photo deleted!")
        }else{
           // print("Photo saved!")
        }
    }

    @IBAction func refreshPress(_ sender: Any) {
        refreshCardStack()
    }

}
