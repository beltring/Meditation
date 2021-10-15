//
//  Constants.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 13.10.21.
//

import Foundation

struct Constants {
    static func getUserProperties() -> UserProperties {
        return UserProperties(timeLimit: 600, currentMeditationTime: 590, lastTime: 0, likeSongs: [1, 13, 4, 5], isContinue: false)
    }
}
