//
//  AnalyticManager.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 15.10.21.
//

import Firebase
import Foundation

class AnalyticManager {
    static let shared = AnalyticManager()
    
    private init() { }
    
    func sendEvent(_ event: Event) {
        FirebaseAnalytics.Analytics.logEvent(event.rawValue, parameters: [:])
    }
    
    func sendEvent(_ event: Event, parameters: [String : Any]) {
        FirebaseAnalytics.Analytics.logEvent(event.rawValue, parameters: parameters)
    }
}
