//
//  FishModel.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import Foundation
import SwiftData

@Model
class Fish {
    var species: String
    var length: Measurement
    var weight: Measurement
    var location: String
    var date: Date
    
    init(species: String, length: Measurement, weight: Measurement, location: String, date: Date) {
        self.species = species
        self.length = length
        self.weight = weight
        self.location = location
        self.date = date
    }
    
    struct Measurement: Codable, Hashable {
        var value: Double
        var unit: Unit
    }
    
    enum Unit: String, Codable, Hashable {
        case lbs = "lbs"
        case kg = "kg"
        case cm = "cm"
        case inch = "in"
    }
}
