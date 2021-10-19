//
//  TimeStatistics.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 19.10.21.
//

import Charts
import Foundation

struct TimeStatistic: Codable {
    let index: Int
    let day: String
    let time: Float
    
    func transformToBarChartDataEntry() -> BarChartDataEntry {
        let entry = BarChartDataEntry(x: Double(index), y: Double(time))
        return entry
    }
}
