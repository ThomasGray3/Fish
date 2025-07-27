//
//  LocationView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @Environment(LocationManager.self) var locationManager
    @State var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var pinLocation: CLLocationCoordinate2D?
    @Binding var showPopover: Bool
    
    var onDismiss: (CLLocationCoordinate2D) -> Void
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    UserAnnotation()
                    if let pinLocation {
                        Marker("", coordinate: pinLocation)
                    }
                }
                .mapControls {
                    MapCompass()
                    MapUserLocationButton()
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        pinLocation = coordinate
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if pinLocation != nil {
                    HStack {
                        Spacer()
                        Button("Delete pin") {
                            pinLocation = nil
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .background(.thinMaterial)
                    .transition(.opacity)
                }
            }
            .navigationTitle("Add Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if let location = pinLocation ?? locationManager.userLocation?.coordinate {
                            showPopover = false
                            onDismiss(location)
                        }
                    }
                    .disabled(pinLocation == nil && locationManager.userLocation?.coordinate == nil)
                }
            }
        }
    }
}
