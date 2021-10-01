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
import UIKit

class SoundsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var meditation: Meditation!
    var player:AVAudioPlayer?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoundTableViewCell.registerCellNib(in: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction func tappedPlayNow(_ sender: UIButton) {
        navigationController?.pushViewController(SoundViewController.initial(), animated: false)
//        let sound = meditation.sounds[0]
//        guard let soundUrl = URL(string: sound.url) else { return }
//        player = try? AVAudioPlayer(data: Data(contentsOf: soundUrl))
//        player?.volume = 2.0
//        player?.prepareToPlay()
//        player?.play()
//        print(player?.duration)
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
        let sound = meditation.sounds[indexPath.section]
        guard let soundUrl = URL(string: sound.url) else { return }
        player = try? AVAudioPlayer(data: Data(contentsOf: soundUrl))
        player?.volume = 2.0
        player?.prepareToPlay()
        player?.play()
        print(player?.duration)
    }
}
