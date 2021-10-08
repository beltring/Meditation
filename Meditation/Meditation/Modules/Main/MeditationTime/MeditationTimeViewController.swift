//
//  MeditationTimeViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 22.09.21.
//

import Firebase
import Kingfisher
import UIKit

class MeditationTimeViewController: UIViewController {
    
    @IBOutlet weak var startNowButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    let user = Auth.auth().currentUser
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupLabel()
    }
    
    // MARK: - Setup
    private func setupButton() {
        startNowButton.titleLabel?.font = UIFont(name: "AlegreyaSans-Medium", size: 25)
    }
    
    private func setupLabel() {
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.timeLabelTap))
        timeLabel.addGestureRecognizer(labelTapGesture)
    }
    
    // MARK: - Actions
    @IBAction func tappedStartNow(_ sender: UIButton) {
        tabBarController?.viewControllers![0] = GeneralViewController.initial()
    }
    
    @objc private func timeLabelTap() {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor(named: "BackgroundColor")
                
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .countDownTimer
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
        dateFormatter.dateFormat = "HH:mm:ss"
            
        var time = dateFormatter.string(from: datePicker.date)
        let hours = time.prefix(3)
        if hours == "00:" {
            time = time.replacingOccurrences(of: "00:", with: "")
        }
        timeLabel.text = time
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
}
