//
//  StringExtensions.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 14.10.21.
//

import Foundation

extension String {
    func convertToSeconds() -> Float {
        let time = self.components(separatedBy: ":")
        guard let hours = Float(time[0]) else { return 0}
        guard let minutes = Float(time[1]) else { return 0}
        let seconds = hours * 3600 + minutes * 60
        return seconds
    }
}
