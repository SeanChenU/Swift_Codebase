//
//  Helpers.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2016/1/5.
//  Copyright © 2016年 Rings. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    
    static let sharedInstance = Helpers()
    
    class func removeNilValuesFromDictionary(dictionary: [String : AnyObject?]) -> [String : AnyObject] {
        var final: [String : AnyObject] = [String : AnyObject]()
        let keysToRemove = Array(dictionary.keys)
        
        for key in keysToRemove {
            if dictionary[key] != nil {
                final[key] = dictionary[key]!
            }
        }
        return final
    }

}

// MARK: Helper For Adding Border Line To View
extension Helpers {
    
    enum Side: Int {
        case Up
        case Down
        case Right
        case Left
    }
    
    private func addBorderLineToView(targetView:UIView, side: Side, options: [String : AnyObject]?) {
        
        // Options
        let lineWidth = options == nil ? 1 : options!["line-width"] as? CGFloat
        let lineColor = options == nil ? UIColor.lightGrayColor() : options!["border-color"] as? UIColor
        
        // Logic helper
        let lineTag = 10090 + side.rawValue
        var haveLine: Bool = false
        var theLine: UIView?
        
        for sv in targetView.subviews {
            if sv.tag == lineTag {
                haveLine = true
                theLine = sv
            }
        }
        
        var theFrame: CGRect?
        
        switch (side) {
        case .Up:
            theFrame = CGRectMake(0, 0, targetView.frame.size.width, lineWidth!)
        case .Down:
            theFrame = CGRectMake(0, targetView.frame.size.height - lineWidth!, targetView.frame.size.width, lineWidth!)
        case .Right:
            theFrame = CGRectMake(targetView.frame.size.width - lineWidth!, 0, lineWidth!, targetView.frame.size.height)
        case .Left:
            theFrame = CGRectMake(0, 0, lineWidth!, targetView.frame.size.height)
        }
        
        if haveLine {
            theLine?.frame = theFrame!
        } else {
            let line = UIView()
            line.backgroundColor = lineColor!
            line.tag = lineTag
            line.frame = theFrame!
            targetView.addSubview(line)
        }
        
    }
    
}

// MARK: Color Helper Examples
class ColorHelper: UIColor {
    
    
    struct bookMarkIconColor {
        static let result_dx = UIColor(red: 253/255, green: 181/255, blue: 63/255, alpha: 1)
        static let result_lt = UIColor(red: 241/255, green: 89/255, blue: 42/255, alpha: 1)
        static let result_dt = UIColor(red: 241/255, green: 138/255, blue: 42/255, alpha: 1)
        static let result_cd = UIColor(red: 135/255, green: 42/255, blue: 241/255, alpha: 1)
        static let result_sr = UIColor(red: 234/255, green: 42/255, blue: 241/255, alpha: 1)
        static let result_ra = UIColor(red: 42/255, green: 55/255, blue: 241/255, alpha: 1)
    }
    
    struct GeneralColor {
        
        static let ResultCareBlue = UIColor(hexString: "69d0d0")
        
        static let InactiveGrey = UIColor(hexString: "DCDCDC")
        static let MiddleGrey = UIColor(hexString: "8C8B8B")
        static let ActiveBlack = UIColor(hexString: "555555")
        static let TextGrey = UIColor(hexString: "828080")
        static let SubtitleDarkGrey = UIColor(hexString: "8E8E8E")
        static let TitleBlack = UIColor(hexString: "555555")
        static let arrowGrey = UIColor(hexString: "D5D5D5")
        static let ReadMoreButtonGrey = UIColor(hexString: "F4F4F4")
        static let BackgroundGrey = UIColor(hexString: "EBEAEA")
        static let InHouseTextGrey = UIColor(hexString: "a1a0a0")
    }
    
    struct IndicatorColor {
        static let SperatorGrey = UIColor(hexString: "EBEAEA")
        static let Orange = UIColor(hexString: "F6621F")
        static let Yellow = UIColor(hexString: "FECC2F")
        static let AvailableGreen = UIColor(hexString: "2ecc71")
        static let StarOrange = UIColor(hexString: "f9a228")
    }
    
    struct RatioColors {
        static let Green = UIColor(hexString: "b2c225")
        static let Yellow = UIColor(hexString: "fecc2f")
        static let Red = UIColor(hexString: "f6621f")
        static let Grey = UIColor(hexString: "d5d5d5")
    }
    
    struct CollectionColor {
        static let CollectionRed = UIColor(hexString: "ff0000")
        static let CollectionGreen = UIColor(hexString: "008000")
        static let CollectionLavender = UIColor(hexString: "E6E6FA")
        static let CollectionPink = UIColor(hexString: "faafbe")
        static let CollectionGray = UIColor(hexString: "808080")
        static let CollectionYellow = UIColor(hexString: "ffff00")
        static let CollectionDarkBlue = UIColor(hexString: "0000a0")
        static let CollectionLightGreen = UIColor(hexString: "90ee90")
        static let CollectionLightBlue = UIColor(hexString: "add8e6")
        static let CollectionLightGold = UIColor(hexString: "fdd017")
    }
}


// MARK: Screen size utility.
extension Helpers {
    
    enum ScreenHeight {
        
        case ThreeFive
        case Four
        case FourSeven
        case FiveFive
        case Undefined
        
    }
    
    func getDeviceHeight() -> ScreenHeight {
        
        let screenHight = UIScreen.mainScreen().bounds.height
        
        if screenHight == 480 {
            return ScreenHeight.ThreeFive
        } else if screenHight ==  568 {
            return ScreenHeight.Four
        } else if screenHight == 667 {
            return ScreenHeight.FourSeven
        } else if screenHight == 736 {
            return ScreenHeight.FiveFive
        } else {
            return ScreenHeight.FourSeven
        }
        
    }
    
    enum ScreenWidth {
        
        case ThreeTwenty
        case ThreeSeventyFive
        case FourFourteen
    }
    
    func getDeviceWidth() -> ScreenWidth {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        if screenWidth == 320 {
            return ScreenWidth.ThreeTwenty
        } else if screenWidth == 375 {
            return ScreenWidth.ThreeSeventyFive
        } else if screenWidth == 414 {
            return ScreenWidth.FourFourteen
        } else {
            return ScreenWidth.FourFourteen
        }
        
    }
    
    func isSmallestDevice() -> Bool {
        return self.getDeviceHeight() == ScreenHeight.ThreeFive
    }
    
    /// ThreeFive and Four
    func isShorterDevice() -> Bool {
        return self.getDeviceHeight() == ScreenHeight.ThreeFive || self.getDeviceHeight() == ScreenHeight.Four
    }
    
    class func getScreenSize() -> CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
}

// MARK: Size does matter.
extension Helpers {
    
    class func getScreen() -> (width: CGFloat, height: CGFloat) {
        let screenBounds = UIScreen.mainScreen().bounds
        return (screenBounds.width, screenBounds.height)
    }
    
}

// Round corners for specific corners
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}

