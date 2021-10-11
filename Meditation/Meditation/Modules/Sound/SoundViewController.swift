//
//  SoundViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 1.10.21.
//

import AVFoundation
import Kingfisher
import UIKit

class SoundViewController: UIViewController {
    
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var musicSlider: UISlider!
    
    var currentSong: Int = 0
    var meditation: Meditation!
    private let playerService = PlayerService.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        play()
        setupPlayButton()
        setupSound()
        musicSlider.value = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    private func setupPlayButton() {
        if playerService.isPlaying {
            playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else {
            playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    private func setupSound() {
        let sound = meditation.sounds[currentSong]
        guard let url = URL(string: sound.imageUrl) else { return}
        soundImage.kf.setImage(with: url)
        nameLabel.text = sound.title
        typeLabel.text = meditation.type.rawValue.capitalized + " sounds"
    }
    
    private func setupPlayer() {
        
    }
    
    // MARK: - Actions
    @IBAction func tappedPlay(_ sender: UIButton) {
        if playerService.isPlaying {
            playerService.player?.pause()
        } else {
            playerService.player?.play()
        }
        playerService.isPlaying.toggle()
        setupPlayButton()
    }
    
    @IBAction func tappedNext(_ sender: UIButton) {
        currentSong += 1
        if currentSong == meditation.sounds.count {
            currentSong = 0
        } else if playerService.isRepeating {
            currentSong -= 1
        } else if playerService.isShuffle {
            currentSong = Int.random(in: 0..<meditation.sounds.count)
        }
        
        playerService.lastSongIndex = currentSong
        musicSlider.value = 0
        play()
    }
    
    @IBAction func tappedPrev(_ sender: UIButton) {
        currentSong -= 1
        if currentSong == -1 {
            currentSong = 0
        } else if playerService.isRepeating {
            currentSong += 1
        } else if playerService.isShuffle {
            currentSong = Int.random(in: 0..<meditation.sounds.count)
        }
        
        playerService.lastSongIndex = currentSong
        musicSlider.value = 0
        play()
    }
    
    @IBAction func tappedRepeat(_ sender: UIButton) {
        playerService.isRepeating.toggle()
        if playerService.isRepeating {
            repeatButton.tintColor = .white
        } else {
            repeatButton.tintColor = UIColor(named: "TextColor")
        }
    }
    
    @IBAction func tappedShuffle(_ sender: UIButton) {
        playerService.isShuffle.toggle()
        if playerService.isShuffle {
            shuffleButton.tintColor = .white
        } else {
            shuffleButton.tintColor = UIColor(named: "TextColor")
        }
    }
    
    @IBAction func tappedBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        playerService.player?.stop()
        playerService.player?.currentTime = TimeInterval(musicSlider.value)
        playerService.player?.play()
    }
    
    // MARK: - Logic
    private func play() {
        let sound = meditation.sounds[currentSong]
        guard let soundUrl = URL(string: sound.url) else { return }
        playerService.play(url: soundUrl)
        playerService.player?.delegate = self
        musicSlider.maximumValue = Float(playerService.player!.duration)
        _ = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateMusicSlider), userInfo: nil, repeats: true)
        setupPlayButton()
        setupSound()
    }
    
    @objc private func updateMusicSlider(){
        musicSlider.value = Float(playerService.player!.currentTime)
    }
}

extension SoundViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            currentSong += 1
        }
        
        if currentSong == meditation.sounds.count {
            currentSong = 0
        } else if playerService.isRepeating {
            currentSong -= 1
        } else if playerService.isShuffle {
            currentSong = Int.random(in: 0..<meditation.sounds.count)
        }
        
        playerService.lastSongIndex = currentSong
        play()
    }
}
