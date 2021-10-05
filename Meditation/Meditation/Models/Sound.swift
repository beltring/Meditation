//
//  Sound.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 27.09.21.
//

import Foundation
import UIKit

struct Sound: Codable {
    let title: String
    let imageUrl: String
    let countListening: Int
    let duration: String
    let url: String
}
