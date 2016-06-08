//
//  DismissMaster.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/6/8.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

class DismissMaster: NSObject {
    
    static let sharedInstance = DismissMaster()
    
    var views: [UIView]?
    
    // ONLY SUPPORTS UITextField and UITextView 
    func registerViewsToDismissKeyboard(views: [UIView], gestureTarget: UIView) {
        self.views = views
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(DismissMaster.tapToDismiss))
        gestureTarget.addGestureRecognizer(tapGes)
    }
    
    func registerViewsToDismissKeyboardForSuperView(views: [UIView]) {
        guard views.count != 0 else {
            return
        }
        
        guard views[0].superview != nil else {
            return
        }
        
        self.registerViewsToDismissKeyboard(views, gestureTarget: views[0].superview!)
    }
    
    func tapToDismiss() {
        guard self.views != nil else {
            return
        }
        
        for view in self.views! {
            if view.isFirstResponder() {
                view.resignFirstResponder()
            }
        }
    }

}
