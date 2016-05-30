//
//  UIKitExtensions.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2016/1/6.
//  Copyright © 2016年 Rings. All rights reserved.
//

import Foundation
import UIKit

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

extension UIView {
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
}
