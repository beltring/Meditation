//
//  LoginViewController.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import Firebase
import SkyFloatingLabelTextField
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= (keyboardFrame.height - 60)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @IBAction func tappedBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func tappedLogin(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else  { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            self?.presentAlert(message: authResult?.user.displayName)
        }
    }
    
    @objc private func signUpTap() {
        navigationController?.pushViewController(SignUpViewController.initial(), animated: false)
    }
}
