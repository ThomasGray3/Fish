//
//  Date+String.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import Foundation

extension Date {

    var string: String? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
