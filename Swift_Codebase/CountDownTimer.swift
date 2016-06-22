//
//  CountDownTimer.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/5/30.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import UIKit
import Foundation

class CountDownTimer: NSObject {
    
    var countDown: NSTimeInterval = 0
    var timer: NSTimer?
    // USE THEM
    var timerFired: (time: NSTimeInterval) -> () = { time in }
    var timerFiredWithMinString: (timeString: String) -> () = { timeString in }
    var timerEnded: () -> () = {}
    
    static let sharedInstance = CountDownTimer()
    
    func startTimer(seconds: NSTimeInterval) {
        self.countDown = seconds
        
        if self.timer != nil {
            self.timer?.invalidate()
        }
        
        self.scheduleTimer()
    }
    
    func fire() {
        self.countDown = self.countDown - 1
        
        if self.countDown >= 0 {
            //
            self.timerFired(time: self.countDown)
            
            self.timerFiredWithMinString(timeString: self.stringFromTimeInterval(self.countDown))
        } else {
            self.nullsTimer()
        }
        
        if self.countDown == 0 {
            self.timerEnded()
        }
    }
    
    // func helper
    func scheduleTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(CountDownTimer.fire), userInfo: nil, repeats: true)
    }
    
    func nullsTimer() {
        self.timer?.invalidate()
        self.countDown = 0
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let ti: NSInteger = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        return "\(minutes):\(seconds)"
    }
    
}
