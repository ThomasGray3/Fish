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
    var date: Date
    var favourite: Bool = false
    var trip: Trip?
    var spot: Spot?
    
    init(species: String,
         length: Double?,
         weight: Double?,
         date: Date,
         trip: Trip?,
         spot: Spot?) {
        self.species = species
        self.length = length
        self.weight = weight
        self.spot = spot
        self.date = date
        self.trip = trip
    }
    
    func updateFavourite() {
        favourite.toggle()
    }
}
