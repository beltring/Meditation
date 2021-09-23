//
//  MeditationTimeViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 22.09.21.
//

import Firebase
import Kingfisher
import UIKit

class MeditationTimeViewController: UIViewController {
    
    @IBOutlet weak var startNowButton: UIButton!
    
    let user = Auth.auth().currentUser
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupNavBar()
    }
    
    // MARK: - Setup
    private func setupButton() {
        startNowButton.titleLabel?.font = UIFont(name: "AlegreyaSans-Medium", size: 25)
        startNowButton.backgroundColor = UIColor(named: "ButtonColor")
        startNowButton.setTitleColor(.white, for: .normal)
        startNowButton.layer.cornerRadius = 10
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.title = "Test"
        navigationController?.navigationBar.isTranslucent = false
        let logo = UIImage(named: "imgLogo")
        let imageView = UIImageView(image: logo)
        let bannerWidth = navigationController?.navigationBar.frame.size.width
        let bannerHeight = navigationController?.navigationBar.frame.size.height
        let bannerX = bannerWidth! / 2 - (logo?.size.width)! / 2
        let bannerY = bannerHeight! / 2 - (logo?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth!, height: bannerHeight!)
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
    }
    
    // MARK: - Actions
    @IBAction func tappedStartNow(_ sender: UIButton) {
        print("Tapped start")
    }
}
