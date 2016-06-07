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
    
    //MARK: - COMPLETELY NEW WAY TO HANDLE KEYBOARD ISSUE
    class func monitorViewsWhoAreCoveredByKeyboard(views:[UIView], targetView: UIView, yOffSet:CGFloat) {
        // LISTEN TO WHEN KEYBOARD SHOWN
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            let kbTopY = KeyboardMaster.getKeyboardHeightFromNotificationDictionary(notification).keyboardY
            
            // FIND OUT WHO ARE FIRST RESPONDERS
            for view in views {
                if view.isFirstResponder() {
                    let viewBottom = KeyboardMaster.getViewBottom(view, baseView: targetView)
                    if viewBottom > kbTopY { // IS BELOW THE KEYBOARD
                        print("\(view) is covered by keyboard!")
                        
                        // MOVE UP THE KEYBOARD
                        KeyboardMaster.moveTheTargetView(targetView, direction: KeyboardMaster.MovingDirection.Up, yOffset: 0)
                        
                    } else { // NOT BELOW THE KEYBOARD
                        
                    }
                }
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            
            KeyboardMaster.moveTheTargetView(targetView, direction: KeyboardMaster.MovingDirection.Down, yOffset: 0)
            
        }
    }
    
    enum MovingDirection {
        case Up
        case Down
    }
    
    // MOVE THE AVOID KEYBOARD
    private class func moveTheTargetView(targetView: UIView, direction: KeyboardMaster.MovingDirection, yOffset: CGFloat) {
        UIView.animateWithDuration(0.5, animations: {
            if direction == .Up {
                let distanceWithDirection: CGFloat = CGFloat(50)
                targetView.bounds.origin.y = targetView.bounds.origin.y + distanceWithDirection + yOffset
            } else if direction == .Down {
                targetView.bounds.origin.y = 0
            }
            
            }) { (done) in
        }
    }
    
    private class func getViewBottom(view: UIView, baseView: UIView) -> CGFloat {
        return KeyboardMaster.getViewFrameFromInBaseView(view, baseView: baseView).origin.y + view.frame.size.height
    }
    
    // GET VIEW'S FRAME THAT IS CONVERTED BY self.view
    // TODO: NESTED VIEW SITUATION
    private class func getViewFrameFromInBaseView(view: UIView, baseView: UIView) -> CGRect {
        let frame = baseView.convertRect(view.frame, fromView: view.superview!)
        return frame
    }
    
    private class func getKeyboardHeightFromNotificationDictionary(notification: NSNotification) -> (keyboardHeight: CGFloat, keyboardY: CGFloat) {
        var dict:Dictionary = notification.userInfo!
        let kbValue:NSValue = dict[UIKeyboardFrameEndUserInfoKey]! as! NSValue
        let kbRect:CGRect = kbValue.CGRectValue()
        let keyboardHeight: CGFloat = kbRect.height
        let fromTopToKeyboard: CGFloat = UIScreen.mainScreen().bounds.height - keyboardHeight
        return (keyboardHeight, fromTopToKeyboard)
    }
    


}
