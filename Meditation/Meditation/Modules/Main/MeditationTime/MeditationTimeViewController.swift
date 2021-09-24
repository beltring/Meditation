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
        setupNavBar()
        setupLabel()
    }
    
    // MARK: - Setup
    private func setupButton() {
        startNowButton.titleLabel?.font = UIFont(name: "AlegreyaSans-Medium", size: 25)
        startNowButton.backgroundColor = UIColor(named: "ButtonColor")
        startNowButton.setTitleColor(.white, for: .normal)
        startNowButton.layer.cornerRadius = 10
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.title = "Test"
        navigationController?.navigationBar.isTranslucent = false
        let logo = UIImage(named: "imgLogo")
        let imageView = UIImageView(image: logo)
        let bannerWidth = navigationController?.navigationBar.frame.size.width
        let bannerHeight = navigationController?.navigationBar.frame.size.height
        let bannerX = bannerWidth! / 2 - (logo?.size.width)! / 2
        let bannerY = bannerHeight! / 2 - (logo?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth!, height: bannerHeight!)
        imageView.contentMode = .scaleAspectFit
        navigationController?.navigationBar.topItem?.titleView = imageView
    }
    
    private func setupLabel() {
        timeLabel.isUserInteractionEnabled = true
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
