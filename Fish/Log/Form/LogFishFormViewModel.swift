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
    var locationName: String = ""
    var locationDefaultName = ""
    var date: Date = Date()
    var selectedTrip: Trip?
    var spot: Spot? = nil
    var saveLocation = true
    
    var formValid: Bool {
        !species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func submitForm(modelContext: ModelContext) {
        let spot = location.map {
            Spot(name: locationName.isEmpty ? locationDefaultName : locationName,
                 latitude: $0.latitude,
                 longitude: $0.longitude)
        }
        modelContext.insert(
            Fish(species: species,
                 length: length,
                 weight: weight,
                 date: date,
                 trip: selectedTrip,
                 spot: saveLocation ? spot : nil))
        resetForm()
    }
    
    func updateLocation(pinLocation: CLLocationCoordinate2D?) {
        if location != pinLocation {
            location = pinLocation
            Task {
                locationDefaultName = await fetchLocationName()
            }
        }
    }
    
    @MainActor func fetchLocationName() async -> String {
        do {
            guard let location else {
                return "Marked Location"
            }

            let places = try await CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location.latitude,
                                                                                  longitude: location.longitude))
            return places.first?.name ?? "Marked Location"
        } catch {
            return "Marked Location"
        }
    }
    
    private func resetForm() {
        species = ""
        length = nil
        weight = nil
        location = nil
        date = Date()
        selectedTrip = nil
        spot = nil
        locationName = ""
        locationDefaultName = ""
        saveLocation = true
    }
}
