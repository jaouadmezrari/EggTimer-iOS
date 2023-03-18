//
//  ViewController.swift
//  EggTimer
//
//  Created by Abdeljaouad Mezrari on 25/02/2023.
//  Copyright © 2023 Abdeljaouad Mezrari. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var progressBarHardness: UIProgressView!
    let hardness_time:[String: Int] = ["Soft": 1, "Medium": 7, "Hard": 12]
    var timer_triggred = false
    var timer = Timer()
    var player : AVAudioPlayer!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let selected_hardness = sender.currentTitle!
        let hardness_seconds = hardness_time[selected_hardness]!*60
        var hardness_seconds_left = hardness_seconds
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if hardness_seconds_left >= 0 {
                let (h,m,s) = self.secondsToHoursMinutesSeconds(hardness_seconds_left)
                
                let progressSeconds = hardness_seconds-hardness_seconds_left
                let progressVal : Float = Float(progressSeconds)/Float(hardness_seconds)
                self.appTitle.text = "Your eggs well be ready in: \(h):\(m):\(s)"
                self.progressBarHardness.progress = progressVal
                hardness_seconds_left -= 1
            } else {
                Timer.invalidate()
                self.appTitle.text = "Your eggs is done"
                self.alarm()
            }
        }
        
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func alarm(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    

}
