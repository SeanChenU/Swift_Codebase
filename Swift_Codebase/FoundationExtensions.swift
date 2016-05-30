//
//  FoundationExtensions.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/5/30.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import Foundation

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
