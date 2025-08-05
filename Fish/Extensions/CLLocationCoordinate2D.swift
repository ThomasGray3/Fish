//
//  CLLocationCoordinate2D.swift
//  Fish
//
//  Created by Thomas Gray on 05/08/2025.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        (lhs.latitude == rhs.latitude
         && lhs.longitude == rhs.longitude)
    }
}
