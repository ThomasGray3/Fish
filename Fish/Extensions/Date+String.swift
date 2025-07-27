//
//  String+Date.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import Foundation

extension String {

    func date() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.date(from: self)
    }
}
