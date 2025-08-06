//
//  SpotModel.swift
//  Fish
//
//  Created by Thomas Gray on 04/08/2025.
//

import Foundation
import SwiftData
import CoreLocation

@Model class Spot {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func distanceTo(userLocation: CLLocation) -> Double {
        return location.distance(from: userLocation) / 1000
    }
}
