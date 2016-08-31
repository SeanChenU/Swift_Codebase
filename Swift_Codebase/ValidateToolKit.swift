//
//  ValidateToolKit.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2016/1/6.
//  Copyright © 2016年 Rings. All rights reserved.
//

import Foundation

// MARK: Basic Validate Tool Kit
class Validate {
    
    class func isValidEmail(testStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
        
    }
    
    class func isPhone(testString: String) -> Bool {
        if testString.characters.count != 10 {
            return false
        }
        
        return true
    }
    
    // Check the number in text is 2 ~ 9
    class func findIsPlural(text: String) -> Bool {
        let numberRegEx = "[0-9]"
        let range = text.rangeOfString(numberRegEx, options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
        let result = range != nil ? true : false
        return result
    }
    
    class func isAllTextFieldsNotEmpty(textFields: [UITextField]) -> Bool {
        let results = textFields.filter { (textField) -> Bool in
            guard textField.text != nil else {
                return false
            }
            
            return !textField.text!.isEmpty
        }
        
        return results.count == textFields.count
    }
    
    class func checkPasswordLength(textField: UITextField) -> Bool {
        return textField.text!.characters.count >= 6
    }
}