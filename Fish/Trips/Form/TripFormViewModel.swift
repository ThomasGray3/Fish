//
//  TripFormViewModel.swift
//  Fish
//
//  Created by Thomas Gray on 29/07/2025.
//

import Foundation
import MapKit
import SwiftData

@Observable class TripFormViewModel {

    var name: String = ""
    var location: CLLocationCoordinate2D?
    var date: Date = Date()

    var formValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func submitForm(modelContext: ModelContext) {
        modelContext.insert(
            Trip(name: name,
                 latitude: location?.latitude,
                 longitude: location?.longitude,
                 date: date))
    }
}
