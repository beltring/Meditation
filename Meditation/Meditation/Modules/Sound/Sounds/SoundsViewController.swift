//
//  SoundsViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 22.09.21.
//

import AVFoundation
import CodableFirebase
import FirebaseFirestore
import FirebaseStorage
import Kingfisher
import UIKit

class SoundsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var meditationImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentSongLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var durationSlider: UISlider!
    
    var meditation: Meditation!
    private let playerService = PlayerService.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundTableViewCell.registerCellNib(in: tableView)
        let viewTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.tappedView))
        bottomView.addGestureRecognizer(viewTapGesture)
        playerService.lastSongIndex = 0
        durationSlider.value = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setup()
        setupBottomView()
        setupPlayButton()
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    func setupBottomView() {
        currentSongLabel.text = meditation.sounds[playerService.lastSongIndex].title
        durationSlider.setThumbImage(UIImage(), for: .normal)
        guard let duration = playerService.player?.duration else { return }
        durationSlider.maximumValue = Float(duration)
        _ = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateMusicSlider), userInfo: nil, repeats: true)
    }
    
    private func setup() {
        guard let url = URL(string: meditation.imageUrl) else { return }
        meditationImage.kf.setImage(with: url)
        titleLabel.text = meditation.type.rawValue.capitalized + " Sounds"
        descriptionLabel.text = meditation.description
    }
    
    private func setupPlayButton() {
        guard playerService.player != nil else {
            playButton.isEnabled = false
            return
        }
        playButton.isEnabled = true
        let config = UIImage.SymbolConfiguration(scale: .large)
        if playerService.isPlaying {
            playButton.setImage(UIImage(systemName: "pause.circle.fill")?.withConfiguration(config), for: .normal)
        } else {
            playButton.setImage(UIImage(systemName: "play.circle.fill")?.withConfiguration(config), for: .normal)
        }
    }

    // MARK: - Actions
    @IBAction func tappedPlayNow(_ sender: UIButton) {
        let vc = SoundViewController.initial()
        vc.meditation = meditation
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func tappedPlay(_ sender: UIButton) {
        if playerService.isPlaying {
            playerService.player?.pause()
        } else {
            playerService.player?.play()
        }
        playerService.isPlaying.toggle()
        setupPlayButton()
    }
    
    @IBAction func tappedLike(_ sender: UIButton) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        heartButton.setImage(UIImage(systemName: "heart.fill")?.withConfiguration(config), for: .normal)
        heartButton.tintColor = .red
    }
    
    @objc func tappedView() {
        let vc = SoundViewController.initial()
        vc.meditation = meditation
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func updateMusicSlider(){
        let time = Float(playerService.player!.currentTime)
        durationSlider.value = time
    }
    
    // MARK: - API calls
    private func getMeditation() {
        Firestore.firestore().collection("meditations").document("calm").getDocument { [weak self] document, error in
            if let document = document {
                guard let self = self else { return }
                self.meditation = try! FirestoreDecoder().decode(Meditation.self, from: document.data()!)
                self.setup()
            } else {
                print("Document does not exist")
            }
        }
    }
}

// MARK: - Extensions
// MARK: - UITableViewDataSource
extension SoundsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return meditation.sounds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SoundTableViewCell.dequeueReusableCell(in: tableView, for: indexPath)
        let sound = meditation.sounds[indexPath.section]
        cell.configure(title: sound.title, imageUrl: sound.imageUrl, count: sound.countListening, duration: sound.duration)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SoundsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "BackgroundColor")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select row")
        let vc = SoundViewController.initial()
        vc.meditation = meditation
        playerService.lastSongIndex = indexPath.section
        playerService.lastSliderValue = 0
        navigationController?.pushViewController(vc, animated: false)
    }
}
