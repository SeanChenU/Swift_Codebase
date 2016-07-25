//
//  NSDateISO8601.swift
//
//  Created by Justin Makaila on 8/11/14.
//  Copyright (c) 2014 Present, Inc. All rights reserved.
//

import Foundation

public extension NSDate {
    public class func ISOStringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.stringFromDate(date).stringByAppendingString("Z")
    }
    
    public class func dateFromISOString(string: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.dateFromString(string)!
    }
    
    public class func dateStringFromISOString(string: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        let date: NSDate = NSDate.dateFromISOString(string)
        return dateFormatter.stringFromDate(date)
    }
    
    public class func timeStringFromISOString(string: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        let date: NSDate = NSDate.dateFromISOString(string)
        return dateFormatter.stringFromDate(date)
    }
    
    public class func ISOStringFromShortStyleDateString(shortStyleDateString: String) -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        let date: NSDate? = dateFormatter.dateFromString(shortStyleDateString)
        if let _date = date {
            return NSDate.ISOStringFromDate(_date)
        }
        return nil
    }
}