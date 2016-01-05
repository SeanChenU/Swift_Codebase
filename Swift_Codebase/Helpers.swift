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



}

// MARK: Helper for add border line to view
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
