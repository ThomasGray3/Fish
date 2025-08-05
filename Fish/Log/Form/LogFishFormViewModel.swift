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
    var date: Date = Date()
    var selectedTrip: Trip?
    var existingSpot: Spot?
    var newSpot: Spot? {
        didSet {
            existingSpot = nil
        }
    }
    var saveLocation = true
    
    var formValid: Bool {
        !species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func submitForm(modelContext: ModelContext) {
        modelContext.insert(
            Fish(species: species,
                 length: length,
                 weight: weight,
                 date: date,
                 trip: selectedTrip,
                 spot: saveLocation ? newSpot ?? existingSpot : nil))
        resetForm()
    }
    
    private func resetForm() {
        species = ""
        length = nil
        weight = nil
        date = Date()
        selectedTrip = nil
        newSpot = nil
        existingSpot = nil
        saveLocation = true
    }
}
