//
//  SignUpViewController.swift
//  Meditation
//
//  Created by User on 21.09.21.
//

import Firebase
import FirebaseStorage
import Kingfisher
import SkyFloatingLabelTextField
import UIKit
import PKHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    
    private var profileImage: UIImage?
    private var user: User!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupButton()
        setupLabel()
        setupTextFields()
        setupSwipe()
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
    }
    
    private func setupLabel() {
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.signInTap))
        signInLabel.addGestureRecognizer(labelTapGesture)
    }
    
    private func setupTextFields() {
        emailTextField.addTarget(self, action: #selector(isValidData(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isValidData(_:)), for: .editingChanged)
    }
    
    private func setupSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(tappedBack(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
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
        guard let image = profileImage else {
            presentAlert(title: "Warning", message: "Please add a photo", cancelTitle: "Ok")
            return
        }
        HUD.show(.progress)
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            if let error = error {
                self?.presentAlert(title: "Error", message: error.localizedDescription, cancelTitle: "Ok")
            }
            
            guard let result = authResult else { return }
            
            let storageRef = Storage.storage().reference().child("users/\(result.user.uid)")
            StorageService.shared.uploadImage(image, at: storageRef) { [weak self] url in
                self?.user = result.user
                let changeRequest = result.user.createProfileChangeRequest()
                changeRequest.displayName = self?.nameTextField.text!
                changeRequest.photoURL = url
                changeRequest.commitChanges { error in
                    guard let error = error else { return }
                    print("LOG Error: \(error.localizedDescription)")
                }
                HUD.hide()
                let rootVC = TabBarViewController.initial()
                self?.navigationController?.setViewControllers([rootVC], animated: true)
            }
        }
    }
    
    @IBAction func tappedAdd(_ sender: UIButton) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc private func signInTap() {
        navigationController?.pushViewController(LoginViewController.initial(), animated: false)
    }
    
    // MARK: - Logic
    @objc private func isValidData(_ textField: UITextField) -> Bool {
        guard let email = emailTextField.text else { return false }
        guard let password = passwordTextField.text else { return false }
        guard let name = nameTextField.text else { return false }
        
        if ValidationService.shared.isValidEmail(email) && ValidationService.shared.isValidPassword(password) && !name.isEmpty {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1
            return true
        }
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.7
        
        return false
    }
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        profileImage = image

        dismiss(animated: true)
    }
}
