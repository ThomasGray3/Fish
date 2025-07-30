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
    var latitude: [Double] = []
    var longitude: [Double] = []
    var date: Date

    @Relationship(deleteRule: .cascade)
    var fish: [Fish] = []
    
    init(name: String,
         latitude: [Double],
         longitude: [Double],
         date: Date) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
}
