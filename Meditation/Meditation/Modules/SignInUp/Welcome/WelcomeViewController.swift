//
//  WelcomeViewController.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signUpLabel: UILabel!
    
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
    }
    
    private func setupLabel() {
        signUpLabel.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.signUpTap))
        signUpLabel.addGestureRecognizer(labelTapGesture)
    }
    
    // MARK: - Actions
    @objc private func signUpTap() {
        AnalyticManager.shared.sendEvent(.tappedSignUp)
        navigationController?.pushViewController(SignUpViewController.initial(), animated: false)
    }
    
    @IBAction private func loginTapped(_ sender: UIButton) {
        AnalyticManager.shared.sendEvent(.loginWithEmailTapped)
        navigationController?.pushViewController(LoginViewController.initial(), animated: false)
    }
}
