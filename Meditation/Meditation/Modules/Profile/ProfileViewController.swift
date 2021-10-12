//
//  ProfileViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 23.09.21.
//

import FirebaseAuth
import Kingfisher
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    private var user: User!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        setupInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInformation()
    }
    
    // MARK: - Setup
    private func setupInformation() {
        profileImage.kf.setImage(with: user.photoURL)
        nameLabel.text = user.displayName
        emailLabel.text = user.email
    }
    
    // MARK: - Actions
    @IBAction private func tappedSignOut(_ sender: UIButton) {
        do
        {
            try Auth.auth().signOut()
            guard let nav = navigationController as? RootNavigationViewController else { return }
            nav.setRootController()
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    
}
