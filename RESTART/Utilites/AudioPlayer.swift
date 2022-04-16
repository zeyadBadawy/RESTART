//
//  AudioPlayer.swift
//  RESTART
//
//  Created by Zeyad Badawy on 15/04/2022.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playAudio(name:String , type:String) {
    
    if let path = Bundle.main.path(forResource: name, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch {
            print("cant not play audio file")
        }
    }
}
