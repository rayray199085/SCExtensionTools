//
//  Double+extension.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func formatNumber() -> String {
        
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
            
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.rounded(toPlaces: 2).truncate(places: 2)
            return "\(sign)\(String(format: "%.2f", formatted))B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.rounded(toPlaces: 2).truncate(places: 2)
            return "\(sign)\(String(format: "%.2f", formatted))M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.rounded(toPlaces: 2).truncate(places: 2)
            return "\(sign)\(String(format: "%.2f", formatted))K"
            
        case 0...:
            return "\(self)"
            
        default:
            return "\(sign)\(self)"
            
        }
    }
}
