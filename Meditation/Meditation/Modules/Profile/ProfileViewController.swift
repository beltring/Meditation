//
//  ProfileViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 23.09.21.
//

import FirebaseAuth
import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func tappedSignOut(_ sender: UIButton) {
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
