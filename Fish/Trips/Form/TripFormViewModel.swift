//
//  TripFormViewModel.swift
//  Fish
//
//  Created by Thomas Gray on 29/07/2025.
//

import Foundation
import MapKit
import SwiftData
import SwiftUI

@Observable class TripFormViewModel {

    var name: String = ""
    var locations: [CLLocationCoordinate2D] = []
    var startDate: Date = Date()
    var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    var selectedColor: Color = .blue

    var formValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !locations.isEmpty
    }
    
    func submitForm(modelContext: ModelContext) {
        modelContext.insert(
            Trip(name: name,
                 latitude: locations.compactMap { $0.latitude },
                 longitude: locations.compactMap { $0.longitude },
                 date: startDate))
    }
}
