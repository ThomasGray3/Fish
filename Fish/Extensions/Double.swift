//
//  Double.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import Foundation

extension Double {

    func toString(decimals: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
