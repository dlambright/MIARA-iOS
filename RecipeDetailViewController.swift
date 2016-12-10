//
//  RecipeDetailViewController.swift
//  EZRecipe
//
//  Created by Charlie Buckets on 11/26/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//


//LOOK INTO THIS CLASS DUSTIN
//https://github.com/zhxnlai/ZLSwipeableViewSwift


import UIKit
import MDCSwipeToChoose


class RecipeDetailViewController: UIViewController, MDCSwipeToChooseDelegate {

    @IBOutlet var lblRecipeTitle: UILabel!
    @IBOutlet var imgFoodImage: UIImageView!
    
    var currentRecipe : Recipe! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFoodImage.image = currentRecipe.image
        lblRecipeTitle.text = currentRecipe.title

        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blue
        options.nopeText = "Delete"
        options.onPan = { state -> Void in
            if state?.thresholdRatio == 1 && state?.direction == MDCSwipeDirection.left {
                print("Photo deleted!")
            }
        }
        
        let newCardView = MDCSwipeToChooseView(frame: CGRect(x : 16, y : self.view.frame.height/2 - 40 , width : self.view.frame.width-32, height : (self.view.frame.height/2)-16-40) , options: options)!
        newCardView.imageView.image = UIImage(named: "Joel_Bridge_II.png")
        self.view.addSubview(newCardView)
        
        var constX : NSLayoutConstraint = NSLayoutConstraint(item: newCardView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(constX)
        
        constX = NSLayoutConstraint(item: newCardView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 200)
        self.view.addConstraint(constX)
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

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
        print("Couldn't decide, huh?")
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
            print("Photo deleted!")
        }else{
            print("Photo saved!")
        }
    }


}
