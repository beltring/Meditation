//
//  PlayerService.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 11.10.21.
//

import AVFoundation
import Foundation

class PlayerService: NSObject {
    static let shared = PlayerService()
    
    var player: AVAudioPlayer?
    var isPlaying = true
    var isRepeating = false
    var isShuffle = false
    var lastSongIndex = 0
    var lastSliderValue: Float = 0.0
    
    private override init() {
        super.init()
    }
    
    func play(url: URL) {
        player = try? AVAudioPlayer(data: Data(contentsOf: url))
        player?.prepareToPlay()
        player?.play()
        isPlaying = true
    }
    
    func play(stringUrl: String) {
        guard let soundUrl = URL(string: stringUrl) else { return }
        player = try? AVAudioPlayer(data: Data(contentsOf: soundUrl))
        player?.prepareToPlay()
        player?.play()
        isPlaying = true
    }
}
