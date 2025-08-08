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
    var spot: Spot?
    
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
                 spot: spot))
        resetForm()
    }
    
    private func resetForm() {
        species = ""
        length = nil
        weight = nil
        date = Date()
        selectedTrip = nil
        spot = nil
    }
}
