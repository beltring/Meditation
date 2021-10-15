//
//  MeditationTimeViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 22.09.21.
//

import CodableFirebase
import Firebase
import FirebaseFirestore
import Kingfisher
import UIKit

class MeditationTimeViewController: UIViewController {
    
    @IBOutlet private weak var startNowButton: UIButton!
    @IBOutlet private weak var timeLabel: UILabel!
    
    private var toolBar = UIToolbar()
    private var datePicker = UIDatePicker()
    private var userProperties: UserProperties!
    private let user = Auth.auth().currentUser
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupLabel()
        setupNavBar()
        getProperties()
    }
    
    // MARK: - Setup
    private func setupButton() {
        startNowButton.titleLabel?.font = UIFont(name: "AlegreyaSans-Medium", size: 25)
    }
    
    private func setupLabel() {
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.timeLabelTap))
        timeLabel.addGestureRecognizer(labelTapGesture)
    }
    
    private func setupNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let controller = tabBarController as? TabBarViewController
        controller?.setupNavBar()
    }
    
    // MARK: - Actions
    @IBAction func tappedStartNow(_ sender: UIButton) {
        AnalyticManager.shared.sendEvent(.tappedStartNow)
        getProperties()
        tabBarController?.viewControllers![0] = GeneralViewController.initial()
    }
    
    @objc private func timeLabelTap() {
        AnalyticManager.shared.sendEvent(.choiceTime)
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor(named: "BackgroundColor")
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .countDownTimer
        datePicker.minuteInterval = 5
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        let buttonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))
        buttonItem.tintColor = .white
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barTintColor = UIColor(named: "BackgroundColor")
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), buttonItem]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let time = dateFormatter.string(from: datePicker.date)
        timeLabel.text = time
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    // MARK: - API calls
    private func getProperties() {
        let uid = user!.uid
        Firestore.firestore().collection("properties").document(uid).getDocument { document, error in
            if let data = document?.data() {
                self.userProperties = try! FirestoreDecoder().decode(UserProperties.self, from: data)
                self.timeLabel.text = self.userProperties.timeLimit.convertToString()
                UserDefaults.standard.set(self.userProperties.currentMeditationTime, forKey: "meditationTime")
                guard let currentLimit = self.timeLabel.text?.convertToSeconds() else { return }
                if self.userProperties.timeLimit != currentLimit {
                    self.userProperties.timeLimit = currentLimit
                    FirestoreService.shared.createProperties(properties: self.userProperties)
                }
            } else {
                print("Document does not exist")
                guard let time = self.timeLabel.text else { return }
                FirestoreService.shared.createProperties(time: time)
            }
        }
    }
}
