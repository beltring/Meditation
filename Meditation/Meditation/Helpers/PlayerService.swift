//
//  PlayerService.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 11.10.21.
//

import AVFoundation
import Foundation
import CodableFirebase
import FirebaseAuth
import FirebaseFirestore

class PlayerService {
    static let shared = PlayerService()
    
    var player: AVAudioPlayer?
    var isPlaying = true
    var isRepeating = false
    var isShuffle = false
    var lastSongIndex = 0
    var lastSliderValue: Float = 0.0
    private var timer: Timer?
    private let service = CoreDataManager.shared
    
    private init() {}
    
    func play(url: URL) {
        if service.checkSong(url: url.absoluteString) {
            let song = service.getSong(url: url)
            guard let data = song.data else { return }
            player = try? AVAudioPlayer(data: data)
        } else {
            player = try? AVAudioPlayer(data: Data(contentsOf: url))
        }
        player?.prepareToPlay()
        player?.play()
        isPlaying = true
    }
    
    func play(stringUrl: String) {
        guard let soundUrl = URL(string: stringUrl) else { return }
        if service.checkSong(url: soundUrl.absoluteString) {
            let song = service.getSong(url: soundUrl)
            guard let data = song.data else { return }
            player = try? AVAudioPlayer(data: data)
        } else {
            player = try? AVAudioPlayer(data: Data(contentsOf: soundUrl))
        }
        player?.prepareToPlay()
        player?.play()
        isPlaying = true
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    @objc private func updateTime() {
        var time = UserDefaults.standard.float(forKey: "meditationTime")
        time += 1
        UserDefaults.standard.set(time, forKey: "meditationTime")
    }
}
