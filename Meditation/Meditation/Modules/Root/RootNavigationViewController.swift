//
//  RootNavigationViewController.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import FirebaseAuth
import UIKit

class RootNavigationViewController: UINavigationController {

    func setRootController() {
        let vc: UIViewController
        
        if Auth.auth().currentUser != nil {
            vc = TabBarViewController.initial()
        } else {
            vc = WelcomeViewController.initial()
        }
        
        setViewControllers([vc], animated: false)
    }
}
