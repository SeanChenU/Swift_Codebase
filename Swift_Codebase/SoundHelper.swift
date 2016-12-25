//
//  SoundHelper.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/12/25.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundHelper: NSObject {
    
    static let sharedInstance = SoundHelper()
    
    func playSound(path: String, type: String) {
        let path: String = NSBundle.mainBundle().pathForResource(path, ofType: type)!
        let fileURL = NSURL(fileURLWithPath: path)
        
        var audioEffect: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(fileURL, &audioEffect)
        AudioServicesPlaySystemSound(audioEffect);
        
//        do {
//            let player: AVAudioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
//            player.volume = 1.0
//            player.prepareToPlay()
//            player.play()
//        } catch {
//            print("Sound helper player failed")
//        }
    }
    
}

extension SoundHelper {
    func playNotificationSound() {
        self.playSound("solemn", type: "mp3")
    }
}
