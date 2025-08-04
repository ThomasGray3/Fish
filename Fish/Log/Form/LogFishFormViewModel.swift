//
//  LogFishFormViewModel.swift
//  Fish
//
//  Created by Thomas Gray on 28/07/2025.
//

import Foundation
import MapKit
import SwiftData

@Observable class LogFishFormViewModel {
    
    var species: String = ""
    var length: Double?
    var weight: Double?
    var location: CLLocationCoordinate2D?
    var date: Date = Date()
    var selectedTrip: Trip?
    
    var formValid: Bool {
        !species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func submitForm(modelContext: ModelContext) {
        modelContext.insert(
            Fish(species: species,
                 length: length,
                 weight: weight,
                 latitude: location?.latitude,
                 longitude: location?.longitude,
                 date: date,
                 trip: selectedTrip))
        resetForm()
    }
    
    private func resetForm() {
        species = ""
        length = nil
        weight = nil
        location = nil
        date = Date()
        selectedTrip = nil
    }
}
