//
//  SoundViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 1.10.21.
//

import UIKit

class SoundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func tappedBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
}
