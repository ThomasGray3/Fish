//
//  FishModel.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import Foundation
import SwiftData

@Model class Fish {
    var species: String
    var length: Double?
    var weight: Double?
    var latitude: Double?
    var longitude: Double?
    var date: Date
    var favourite: Bool = false
    var trip: Trip?
    
    init(species: String,
         length: Double?,
         weight: Double?,
         latitude: Double?,
         longitude: Double?,
         date: Date,
         trip: Trip?) {
        self.species = species
        self.length = length
        self.weight = weight
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.trip = trip
    }
    
    func updateFavourite() {
        favourite.toggle()
    }
}
