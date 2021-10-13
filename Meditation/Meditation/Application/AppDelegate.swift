//
//  AppDelegate.swift
//  Meditation
//
//  Created by User on 20.09.21.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AVFoundation
import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioSessionObserver: Any!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let vc = RootNavigationViewController()
        vc.setRootController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        let notificationCenter = NotificationCenter.default
        
        audioSessionObserver = notificationCenter.addObserver(forName: AVAudioSession.mediaServicesWereResetNotification,
                                                              object: nil,
                                                              queue: nil) { [unowned self] _ in
            self.setUpAudioSession()
        }
        
        // Configure the audio session initially.
        setUpAudioSession()
        
        AppCenter.start(withAppSecret: "c57100a2-d0e6-44ab-ada9-37285ae838ab", services:[
          Analytics.self,
          Crashes.self
        ])
        
        return true
    }
    
    private func setUpAudioSession() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .longFormAudio)
        } catch {
            print("Failed to set audio session route sharing policy: \(error)")
        }
    }
}

