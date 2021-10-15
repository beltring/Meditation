//
//  TabBarViewController.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import FirebaseAuth
import Kingfisher
import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupNavBar()
    }
    
    // MARK: - Setup
    private func setupTabBar() {
        tabBar.barTintColor = UIColor(named: "BackgroundColor")
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
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
    
    private func setupItems(_ item: UITabBarItem) {
        let index = tabBar.items?.firstIndex(of: item)
        if index == 2 {
            let item = UIBarButtonItem(title: "edit", style: .done, target: self, action: #selector(self.tappedEdit))
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = item
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .white
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.style = .plain
            self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Alegreya Sans", size: 15)!]
        } else {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
        }
    }
    
    // MARK: - Actions
    @objc private func tappedEdit() {
        AnalyticManager.shared.sendEvent(.editScreen)
        present(EditProfileViewController.initial(), animated: true, completion: nil)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setupItems(item)
    }
}
