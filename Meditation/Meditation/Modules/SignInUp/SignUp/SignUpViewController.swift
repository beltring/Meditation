//
//  SignUpViewController.swift
//  Meditation
//
//  Created by User on 21.09.21.
//

import Firebase
import Kingfisher
import SkyFloatingLabelTextField
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    
    private var profileImage = UIImageView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupButton()
        setupLabel()
        setupTextFields()
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
        signUpButton.titleLabel?.font = UIFont(name: "AlegreyaSans-Medium", size: 25)
        signUpButton.backgroundColor = UIColor(named: "ButtonColor")
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 10
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.7
    }
    
    private func setupLabel() {
        signInLabel.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.signInTap))
        signInLabel.addGestureRecognizer(labelTapGesture)
    }
    
    private func setupTextFields() {
        emailTextField.addTarget(self, action: #selector(isValidData(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isValidData(_:)), for: .editingChanged)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= (keyboardFrame.height)
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
    
    @IBAction func tappedSignUp(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else  { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                self?.presentAlert(title: "Error", message: error.localizedDescription)
            }
            
            guard let result = authResult else { return }
            
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = self?.nameTextField.text!
            changeRequest.photoURL = URL(string: "https://i.stack.imgur.com/l60Hf.png")
            changeRequest.commitChanges { error in
                guard let error = error else { return }
                print("LOG Error: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func tappedAdd(_ sender: UIButton) {
        print("Add photo")
    }
    
    @objc private func signInTap() {
        navigationController?.pushViewController(LoginViewController.initial(), animated: false)
    }
    
    // MARK: - Logic
    @objc private func isValidData(_ textField: UITextField) -> Bool {
        guard let email = emailTextField.text else { return false }
        guard let password = passwordTextField.text else { return false }
        guard let name = nameTextField.text else { return false }
        
        if isValidEmail(email) && isValidPassword(password) && !name.isEmpty {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1
            return true
        }
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.7
        
        return false
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        if password.count > 3 {
            return true
        }
        
        return false
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
