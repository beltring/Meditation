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
    
    var currentSong: Int = 0
    var meditation: Meditation!
    
    private var player: AVAudioPlayer?
    private var isPlaying = true
    private var isRepeating = false
    private var isShuffle = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        play()
        setupPlayButton()
        setupSound()
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
        if isPlaying {
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
        typeLabel.text = meditation.type.rawValue.uppercased() + " sounds"
    }
    
    // MARK: - Actions
    @IBAction func tappedPlay(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
        setupPlayButton()
    }
    
    @IBAction func tappedNext(_ sender: UIButton) {
        currentSong += 1
        if currentSong == meditation.sounds.count {
            currentSong = 0
        } else if isRepeating {
            currentSong -= 1
        } else if isShuffle {
            currentSong = Int.random(in: 0..<meditation.sounds.count)
        }

        play()
    }
    
    @IBAction func tappedPrev(_ sender: UIButton) {
        currentSong -= 1
        if currentSong == -1 {
            currentSong = 0
        } else if isRepeating {
            currentSong += 1
        } else if isShuffle {
            currentSong = Int.random(in: 0..<meditation.sounds.count)
        }

        play()
    }
    
    @IBAction func tappedRepeat(_ sender: UIButton) {
        isRepeating.toggle()
        if isRepeating {
            repeatButton.tintColor = .white
        } else {
            repeatButton.tintColor = UIColor(named: "TextColor")
        }
    }
    
    @IBAction func tappedShuffle(_ sender: UIButton) {
        isShuffle.toggle()
        if isShuffle {
            shuffleButton.tintColor = .white
        } else {
            shuffleButton.tintColor = UIColor(named: "TextColor")
        }
    }
    
    @IBAction func tappedBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Logic
    private func play() {
        let sound = meditation.sounds[currentSong]
        guard let soundUrl = URL(string: sound.url) else { return }
        player = try? AVAudioPlayer(data: Data(contentsOf: soundUrl))
        player?.prepareToPlay()
        player?.play()
        player?.delegate = self
        isPlaying = true
        setupPlayButton()
        setupSound()
    }
}

extension SoundViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            currentSong += 1
        }
        
        if currentSong == meditation.sounds.count {
            currentSong = 0
        } else if isRepeating {
            currentSong -= 1
        } else if isShuffle {
            currentSong = Int.random(in: 0..<meditation.sounds.count)
        }

        play()
    }
}
