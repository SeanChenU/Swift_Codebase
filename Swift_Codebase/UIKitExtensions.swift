//
//  UIKitExtensions.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2016/1/6.
//  Copyright © 2016年 Rings. All rights reserved.
//

import Foundation
import UIKit

// MARK: Extensions
extension String {
    func base64decode() -> NSData? {
        let base64 = self.stringByReplacingOccurrencesOfString("-", withString: "+", options: NSStringCompareOptions(rawValue: 0), range: nil)
            .stringByReplacingOccurrencesOfString("_", withString: "/", options: NSStringCompareOptions(rawValue: 0), range: nil)
        
        
        return NSData(base64EncodedString: base64, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
    }
    
    /**
    Encode a String to Base64
    
    :returns:
    */
    func toBase64() -> String {
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
    
    static func randomStringWithLength (len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString as String
    }
    
}

extension String {
    
    static func findStringBetweenStrings(start: String, end:String, origin:String) -> String? {
        
        let nsAString = origin as NSString
        
        let startLoc = nsAString.rangeOfString(start).location
        let endLoc = nsAString.rangeOfString(end).location
        
        if startLoc > nsAString.length + 1 || endLoc > nsAString.length + 1 {
            return nil
        }
        
        let result = nsAString.substringWithRange(NSMakeRange(startLoc + start.characters.count, endLoc - startLoc - start.characters.count))
        
        print("Find string between strings result: \(result)")
        
        return result
        
    }
    
}

extension String {
    
    func capitalizeFirstCharInSentence(callback:(resultSentence: String) -> Void) {
        
        self.uppercaseString.enumerateSubstringsInRange(self.characters.indices, options: .BySentences) { (sub, _, _, _)  in
            var result = ""
            result += String(sub!.characters.prefix(1))
            result += String(sub!.characters.dropFirst(1)).lowercaseString
            
            callback(resultSentence: result)
        }
        
    }
    
}

extension SequenceType where Generator.Element: Comparable {
    func distinct() -> [Generator.Element] {
        var rtn: [Generator.Element] = []
        
        for x in self {
            if !rtn.contains(x) {
                rtn.append(x)
            }
        }
        return rtn
    }
}

extension UILabel {
    
    func animateSelf(toColor: UIColor) {
        let origin = self.textColor
        UIView.transitionWithView(self, duration: 0.15, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.textColor = toColor
            }) { (done) -> Void in
                self.textColor = origin
        }
    }
    
}

extension UIButton {
    
    func animateItself() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.backgroundColor = self.backgroundColor?.darker()
            }) { (done) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.backgroundColor = self.backgroundColor?.lighter()
                })
        }
    }
    
}

extension UIColor { // darker
    
    func darker() -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * 0.8, alpha: a)
        }
        
        return UIColor.whiteColor()
    }
    
    func lighter() -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * 1.25, alpha: a)
        }
        
        return UIColor.whiteColor()
    }
    
}
