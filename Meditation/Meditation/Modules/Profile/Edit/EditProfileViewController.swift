//
//  EditProfileViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 8.10.21.
//

import FirebaseAuth
import FirebaseStorage
import Kingfisher
import PKHUD
import SkyFloatingLabelTextField
import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var emailTextField: SkyFloatingLabelTextField!
    
    private var user: User!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        user = Auth.auth().currentUser
        setupImage()
    }
    
    // MARK: - Setup
    private func setupImage() {
        let imageTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.tappedImage))
        profileImage.addGestureRecognizer(imageTapGesture)
        
        guard let url = user?.photoURL else { return }
        profileImage.kf.setImage(with: url)
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

    // MARK: - Actions
    @IBAction func tappedEdit(_ sender: UIButton) {
        AnalyticManager.shared.sendEvent(.editTapped)
        HUD.show(.progress)
        let storageRef = Storage.storage().reference().child("users/\(user.uid)")
        StorageService.shared.uploadImage(profileImage.image!, at: storageRef) { [weak self] url in
            guard let self = self else { return }
            let email = self.emailTextField.text ?? ""
            let name = self.nameTextField.text ?? ""
            if ValidationService.shared.isValidEmail(email) {
                self.user.updateEmail(to: email) { error in
                    if error == nil {
                        self.presentAlert(title: "Error", message: "The mail change operation is confidential and requires recent authentication. Log in again before repeating this request.", cancelTitle: "Ok")
                    }
                }
            }
            let changeRequest = self.user.createProfileChangeRequest()
            if !name.isEmpty {
                changeRequest.displayName = name
            }
            changeRequest.photoURL = url
            changeRequest.commitChanges { error in
                guard let error = error else { return }
                print("LOG Error: \(error.localizedDescription)")
            }
            HUD.hide()
            self.dismiss(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func tappedImage() {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        present(photoPicker, animated: true, completion: nil)
    }
}

// MARK: - Extensions
// MARK: - UIImagePickerControllerDelegate&UINavigationControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        profileImage.image = selectedImage

        dismiss(animated: true)
    }
}
