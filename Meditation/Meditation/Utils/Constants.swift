//
//  Constants.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 19.10.21.
//

import Charts
import Foundation

struct Statistic {
    static func getEntry() -> [BarChartDataEntry] {
        let e1 = BarChartDataEntry(x: Double(0), y: 270)
        let e2 = BarChartDataEntry(x: Double(1), y: 700)
        let e3 = BarChartDataEntry(x: Double(2), y: 130)
        let e4 = BarChartDataEntry(x: Double(3), y: 530)
        let e5 = BarChartDataEntry(x: Double(4), y: 312)
        let e6 = BarChartDataEntry(x: Double(5), y: 991)
        let e7 = BarChartDataEntry(x: Double(6), y: 99)
        
        return [e1, e2, e3, e4, e5, e6, e7]
    }
}
