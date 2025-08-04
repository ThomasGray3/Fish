//
//  FishApp.swift
//  Fish
//
//  Created by Thomas Gray on 14/07/2025.
//

import SwiftUI
import SwiftData

@main
struct FishApp: App {
    @State var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            BaseTabView()
        }
        .modelContainer(for: [Fish.self, Trip.self, Spot.self])
        .environment(locationManager)
    }
}
