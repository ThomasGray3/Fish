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
    var name: String
    var latitude: Double
    var longitude: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
