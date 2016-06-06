//
//  UITextViewAction.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/6/6.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//


class TextViewAction: NSObject {
    
    static let sharedInstance = TextViewAction()
    
    var textViews: [UITextView]?
    
    func registerTextViewsToDismissKeyboard(textViews: [UITextView], gestureTargetView: UIView) {
        self.textViews = textViews
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(TextViewAction.tapToDismiss))
        gestureTargetView.addGestureRecognizer(tapGes)
    }
    
    func tapToDismiss() {
        guard self.textViews != nil else {
            return
        }
        
        for tv in self.textViews! {
            tv.resignFirstResponder()
        }
    }
}
