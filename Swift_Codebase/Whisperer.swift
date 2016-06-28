//
//  Whisperer.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/6/28.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import Whisper

class Whisperer: NSObject {

    class func murmurError(title: String) {
        let murmur = Murmur(title: title)
        Whistle(murmur)
    }
    
}
