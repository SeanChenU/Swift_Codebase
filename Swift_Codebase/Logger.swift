//
//  Logger.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/7/5.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import UIKit
import XCGLogger

class Logger: NSObject {

    // ADD THIS LINE in didFinishLaunching
    // log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: "path/to/file", fileLogLevel: .Debug)
    
    class func me() -> XCGLogger {
        return XCGLogger.defaultInstance()
    }
    
}
