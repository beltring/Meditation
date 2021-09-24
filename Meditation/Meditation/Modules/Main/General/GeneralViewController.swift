//
//  GeneralViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 23.09.21.
//

import UIKit

class GeneralViewController: UIViewController {

    @IBOutlet weak var calmButton: UIButton!
    @IBOutlet weak var relaxButton: UIButton!
    @IBOutlet weak var focusButton: UIButton!
    @IBOutlet weak var anxiousButton: UIButton!
    @IBOutlet weak var meditation101View: MeditationProgramsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meditation101View.layer.masksToBounds = true
        meditation101View.layer.cornerRadius = 10
    }

}
