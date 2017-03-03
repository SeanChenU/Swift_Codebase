//
//  Hover.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/6/9.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import ActionKit

class HoverButton: UIButton {
    
    var isHighlightedButton: Bool = true
    override var highlighted: Bool {
        didSet {
            if self.isHighlightedButton {
                self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
            } else {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
}


extension UIView {

    func becomeClickable(customization: (button: HoverButton) -> Void, action: (button: HoverButton) -> Void) {
        self.userInteractionEnabled = true
        
        let hoverButton: HoverButton = HoverButton(frame: CGRectMake(0,0,self.width(), self.height()))
        self.addSubview(hoverButton)
        
        customization(button: hoverButton)
        
        hoverButton.addTapHandler { 
            action(button: hoverButton)
        }
    }
    
    func becomeUnclickable() {
        for subview in self.subviews {
            if subview is HoverButton {
                subview.removeFromSuperview()
            }
        }
    }
}
