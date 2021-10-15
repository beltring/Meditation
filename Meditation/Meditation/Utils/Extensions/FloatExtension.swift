//
//  FloatExtension.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 14.10.21.
//

import Foundation

extension Float {
    func convertToString() -> String {
        let hours = Int(self) % 86400 / 3600
        let minutes = Int(self) % 3600 / 60
        
        return "\(hours):\(minutes)"
    }
}
