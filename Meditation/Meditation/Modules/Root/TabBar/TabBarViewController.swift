//
//  TabBarViewController.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Setup
    private func setupTabBar() {
        tabBar.barTintColor = UIColor(named: "BackgroundColor")
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
//        tabBar.shadowImage = UIImage()
//        tabBar.backgroundImage = UIImage()
    }
}
