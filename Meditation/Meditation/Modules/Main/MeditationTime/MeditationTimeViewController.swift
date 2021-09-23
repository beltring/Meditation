//
//  MeditationTimeViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 22.09.21.
//

import UIKit

class MeditationTimeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
