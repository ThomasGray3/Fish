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
    var locationDefaultName = "Marked Location"
    var date: Date = Date()
    var selectedTrip: Trip?
    var saveLocation = true
    
    var formValid: Bool {
        !species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func submitForm(modelContext: ModelContext) {
        let spot = location.map {
            Spot(name: locationName,
                 latitude: $0.latitude,
                 longitude: $0.longitude)
        }
        if let spot {
            modelContext.insert(spot)
        }
        modelContext.insert(
            Fish(species: species,
                 length: length,
                 weight: weight,
                 latitude: location?.latitude,
                 longitude: location?.longitude,
                 date: date,
                 trip: selectedTrip,
                 spot: spot))
        resetForm()
    }
    
    func updateLocation(pinLocation: CLLocationCoordinate2D?) {
        if (location?.latitude != pinLocation?.latitude
            && location?.longitude != pinLocation?.longitude) {
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
    }
}
