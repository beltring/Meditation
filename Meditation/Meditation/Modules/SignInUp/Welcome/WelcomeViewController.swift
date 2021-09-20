//
//  WelcomeViewController.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupLabel()
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
    private func setupButton() {
        loginButton.titleLabel?.font = UIFont(name: "AlegreyaSans-Medium", size: 25)
        loginButton.backgroundColor = UIColor(named: "ButtonColor")
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
    }
    
    private func setupLabel() {
        signUpLabel.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.signUpTap))
        signUpLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func signUpTap() {
        print("tapped")
    }
}
