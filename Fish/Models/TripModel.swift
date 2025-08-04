//
//  TripModel.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import Foundation
import SwiftData

@Model
class Trip {
    var name: String
    var startDate: Date
    var endDate: Date

    @Relationship(deleteRule: .cascade)
    var fish: [Fish] = []
    
    init(name: String,
         startDate: Date,
         endDate: Date) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
    }
}
