//
//  SoundViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 1.10.21.
//

import AVFoundation
import CodableFirebase
import FirebaseAuth
import FirebaseFirestore
import Kingfisher
import UIKit

class SoundViewController: UIViewController {
    
    @IBOutlet private weak var soundImage: UIImageView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var repeatButton: UIButton!
    @IBOutlet private weak var shuffleButton: UIButton!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var musicSlider: UISlider!
    
    var meditation: Meditation!
    private var userProperties: UserProperties!
    private let playerService = PlayerService.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayButton()
        play()
        setupSound()
        musicSlider.value = 0
        getProperties()
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
        let index = playerService.lastSongIndex
        let sound = meditation.sounds[index]
        guard let url = URL(string: sound.imageUrl) else { return}
        soundImage.kf.setImage(with: url)
        nameLabel.text = sound.title
        typeLabel.text = meditation.type.rawValue.capitalized + " sounds"
        if playerService.lastSliderValue != 0 {
            playerService.player?.stop()
            playerService.player?.currentTime = TimeInterval(playerService.lastSliderValue)
            playerService.player?.play()
        }
    }
    
    // MARK: - Actions
    @IBAction private func tappedPlay(_ sender: UIButton) {
        if playerService.isPlaying {
            playerService.player?.pause()
            playerService.stopTimer()
            let time = UserDefaults.standard.float(forKey: "meditationTime")
            userProperties.currentMeditationTime = time
            FirestoreService.shared.createProperties(properties: userProperties)
        } else {
            playerService.player?.play()
            playerService.startTimer()
        }
        playerService.isPlaying.toggle()
        setupPlayButton()
    }
    
    @IBAction private func tappedNext(_ sender: UIButton) {
        var index = playerService.lastSongIndex
        index += 1
        if index == meditation.sounds.count {
            index = 0
        } else if playerService.isRepeating {
            index -= 1
        } else if playerService.isShuffle {
            index = Int.random(in: 0..<meditation.sounds.count)
        }
        
        playerService.lastSongIndex = index
        musicSlider.value = 0
        playerService.lastSliderValue = 0
        let time = UserDefaults.standard.float(forKey: "meditationTime")
        userProperties.currentMeditationTime = time
        FirestoreService.shared.createProperties(properties: userProperties)
        playerService.stopTimer()
        play()
    }
    
    @IBAction private func tappedPrev(_ sender: UIButton) {
        var index = playerService.lastSongIndex
        index -= 1
        if index == -1 {
            index = 0
        } else if playerService.isRepeating {
            index += 1
        } else if playerService.isShuffle {
            index = Int.random(in: 0..<meditation.sounds.count)
        }

        playerService.lastSongIndex = index
        musicSlider.value = 0
        playerService.lastSliderValue = 0
        let time = UserDefaults.standard.float(forKey: "meditationTime")
        userProperties.currentMeditationTime = time
        FirestoreService.shared.createProperties(properties: userProperties)
        playerService.stopTimer()
        play()
    }
    
    @IBAction private func tappedRepeat(_ sender: UIButton) {
        playerService.isRepeating.toggle()
        if playerService.isRepeating {
            repeatButton.tintColor = .white
        } else {
            repeatButton.tintColor = UIColor(named: "TextColor")
        }
    }
    
    @IBAction private func tappedShuffle(_ sender: UIButton) {
        playerService.isShuffle.toggle()
        if playerService.isShuffle {
            shuffleButton.tintColor = .white
        } else {
            shuffleButton.tintColor = UIColor(named: "TextColor")
        }
    }
    
    @IBAction private func tappedBack(_ sender: UIButton) {
        let time = UserDefaults.standard.float(forKey: "meditationTime")
        userProperties.currentMeditationTime = time
        FirestoreService.shared.createProperties(properties: userProperties)
        let vc = navigationController?.viewControllers.first as! SoundsViewController
        vc.setupBottomView()
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction private func sliderAction(_ sender: UISlider) {
        playerService.player?.stop()
        playerService.player?.currentTime = TimeInterval(musicSlider.value)
        playerService.player?.play()
    }
    
    // MARK: - Logic
    private func play() {
        let index = playerService.lastSongIndex
        let sound = meditation.sounds[index]
        guard let soundUrl = URL(string: sound.url) else { return }
        playerService.play(url: soundUrl)
        playerService.player?.delegate = self
        musicSlider.maximumValue = Float(playerService.player!.duration)
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMusicSlider), userInfo: nil, repeats: true)
        playerService.startTimer()
        setupPlayButton()
        setupSound()
    }
    
    @objc private func updateMusicSlider(){
        let time = Float(playerService.player!.currentTime)
//        userProperties.currentMeditationTime -= userProperties.lastTime
//        userProperties.lastTime = time
//        userProperties.currentMeditationTime += time
        musicSlider.value = time
        playerService.lastSliderValue = time
        checkMeditationTime()
    }
    
    private func checkMeditationTime() {
        if userProperties.currentMeditationTime >= userProperties.timeLimit && !userProperties.isContinue {
            playerService.player?.pause()
            playerService.isPlaying = false
            setupPlayButton()
            FirestoreService.shared.createProperties(properties: userProperties)
            presentAlert(title: "Warning", message: "You used the time limit.Do you want to continue?", cancelTitle: "Cancel", cancelStyle: .default, cancelHandler: { [weak self] _ in
                self?.playerService.player?.stop()
                self?.playerService.stopTimer()
                let vc = self?.navigationController?.viewControllers.first as! SoundsViewController
                vc.setupBottomView()
                self?.navigationController?.popViewController(animated: false)
            }, otherActions: [UIAlertAction(title: "Continue", style: .default, handler: { [weak self] _ in
                self?.playerService.isPlaying.toggle()
                self?.setupPlayButton()
                self?.playerService.player?.play()
                self?.userProperties.isContinue = true
            })])
        }
    }
    
    // MARK: - API calls
    private func getProperties() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("properties").document(uid).getDocument { [weak self] document, error in
            if let data = document?.data() {
                self?.userProperties = try! FirestoreDecoder().decode(UserProperties.self, from: data)
            } else {
                print("Document does not exist")
            }
        }
    }
}

// MARK: - Extensions
// MARK: - AVAudioPlayerDelegate
extension SoundViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playerService.stopTimer()
        var index = playerService.lastSongIndex
        if flag {
            index += 1
        }
        
        if index == meditation.sounds.count {
            index = 0
        } else if playerService.isRepeating {
            index -= 1
        } else if playerService.isShuffle {
            index = Int.random(in: 0..<meditation.sounds.count)
        }
        
        let time = UserDefaults.standard.float(forKey: "meditationTime")
        userProperties.currentMeditationTime = time
        FirestoreService.shared.createProperties(properties: userProperties)
        playerService.lastSongIndex = index
        play()
    }
}
