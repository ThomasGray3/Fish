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
    var length: Double?
    var weight: Double?
    var latatude: Double?
    var longitude: Double?
    var date: Date
    var favourite: Bool = false
    
    init(species: String,
         length: Double?,
         weight: Double?,
         latatude: Double?,
         longitude: Double?,
         date: Date) {
        self.species = species
        self.length = length
        self.weight = weight
        self.latatude = latatude
        self.longitude = longitude
        self.date = date
    }
    
    func updateFavourite() {
        favourite.toggle()
    }
}
