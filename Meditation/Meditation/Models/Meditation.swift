//
//  Meditation.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 28.09.21.
//

import Foundation

struct Meditation: Codable {
    let type: MeditationType
    let sounds: [Sound]
}
