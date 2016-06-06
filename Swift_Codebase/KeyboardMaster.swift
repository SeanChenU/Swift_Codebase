//
//  KeyboardMaster.swift
//  Rings
//
//  Created by Sean Chen on 2015/2/11.
//  Copyright (c) 2015年 SEAN. All rights reserved.
//
// 1. Remove keyboard
// 2. Move up the UI control that hidden by keyboard when became first responder


import UIKit

class KeyboardMaster: NSObject {

    // Put in AppDelegate
    // Keyboard Master hehe, listen to keyboard show up and get its height
    class func listenToWhenKeyboardShown(completeWithFromTopY:(CGFloat) -> Void) {
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            var dict:Dictionary = notification.userInfo!
            let kbValue:NSValue = dict[UIKeyboardFrameEndUserInfoKey]! as! NSValue
            let kbRect:CGRect = kbValue.CGRectValue()
            let keyboardHeight: CGFloat = kbRect.height
            let fromTopToKeyboard: CGFloat = UIScreen.mainScreen().bounds.height - keyboardHeight
            NSUserDefaults.standardUserDefaults().setObject(NSNumber(float: Float(fromTopToKeyboard)), forKey: "keyboardY")
            print("Keyboard from top: \(fromTopToKeyboard)")
            
            completeWithFromTopY(fromTopToKeyboard)
            
//            self.monitorWhoIsCoveredByKeyboard()
        }
        
    }
    
    // Put in didBeginEditing
    class func monitorWhoIsCoveredByKeyboard(target target:UIViewController) {
        for view in target.view.subviews {
            if view.isFirstResponder() {
                let bottom = view.frame.size.height + view.frame.origin.y
                if NSUserDefaults.standardUserDefaults().objectForKey("keyboardY") != nil {
                    if bottom > CGFloat(NSUserDefaults.standardUserDefaults().objectForKey("keyboardY")!.floatValue) && target.view.frame.origin.y == 0 {
                        print("Need to move up")
//                        println("A: \(target.view.frame.origin.y)")
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            target.view.frame.origin.y = target.view.frame.origin.y - (bottom - CGFloat(NSUserDefaults.standardUserDefaults().objectForKey("keyboardY")!.floatValue)) - 50
                        })
                    }
                }
            }
        }
    }
    
    // Put in didBeginEditing, when the target is `UIView`
    class func monitorWhoIsCoveredByKeyboard(targetView targetView:UIView, yOffSet:CGFloat) {
    
        for view in targetView.subviews {
            if view.isFirstResponder() {
                let bottom = view.frame.size.height + view.frame.origin.y
                if NSUserDefaults.standardUserDefaults().objectForKey("keyboardY") != nil {
                    if bottom > CGFloat(NSUserDefaults.standardUserDefaults().objectForKey("keyboardY")!.floatValue) {
                        print("Need to move up")
                        //                        println("A: \(target.view.frame.origin.y)")
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            let delta = (bottom - CGFloat(NSUserDefaults.standardUserDefaults().objectForKey("keyboardY")!.floatValue))
                            targetView.bounds.origin.y = targetView.bounds.origin.y + delta + 50 + yOffSet
                        })
                    }
                }
            }
        }
    
    }
    
    
    // Put in didEndEditing
    class func moveEverythingBackToOriginal(target target:UIViewController) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            target.view.frame.origin.y = 0
        })
    }
    
    // Put in didEndEditing, when the target is `UIView`
    class func moveEverythingBackToOriginal(targetView targetView:UIView) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            targetView.bounds.origin.y = 0
        })
    }

}
