//
//  UserProperties.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 13.10.21.
//

import Foundation

struct UserProperties: Codable {
    var timeLimit: Float
    var currentMeditationTime: Float
    var likeSongs: [Int]
    var isContinue: Bool
}
