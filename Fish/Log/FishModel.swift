//
//  FishModel.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import Foundation
import SwiftData
import MapKit

@Model
class Fish {
    var species: String
    var length: Measurement
    var weight: Measurement
    var latatude: Double?
    var longitude: Double?
    var date: Date
    
    init(species: String, length: Measurement, weight: Measurement, latatude: Double?, longitude: Double?, date: Date) {
        self.species = species
        self.length = length
        self.weight = weight
        self.latatude = latatude
        self.longitude = longitude
        self.date = date
    }
    
    struct Measurement: Codable, Hashable, Comparable {
        static func < (lhs: Fish.Measurement, rhs: Fish.Measurement) -> Bool {
            lhs.value ?? 0 < rhs.value ?? 0
        }
        
        var value: Double?
        var unit: Unit
    }
    
    enum Unit: String, Codable, Hashable {
        case lbs = "lbs"
        case kg = "kg"
        case cm = "cm"
        case inch = "in"
    }
}
