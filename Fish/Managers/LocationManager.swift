//
//  LocationManager.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import CoreLocation
import MapKit
import SwiftUI

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored private let manager = CLLocationManager()
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
    
    private func checkLocationAuthorizationStatus() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            userLocation = manager.location
        default:
            break
        }
    }
}
