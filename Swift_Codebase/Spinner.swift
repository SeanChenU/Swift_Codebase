//
//  Spinner.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/7/5.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//
//  SwiftSpinner Wrapper

import UIKit
import SwiftSpinner

class Spinner: NSObject {

    class func show(title: String) {
        SwiftSpinner.show(title)
    }
    
    class func showStatic(title: String) {
        SwiftSpinner.show(title, animated: false)
    }
    
    class func hide(completion: (() -> Void)?) {
        SwiftSpinner.hide(completion)
    }
    
}
