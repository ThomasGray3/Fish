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
    @State var cameraPosition: MapCameraPosition = .automatic
    @State var pinLocation: CLLocationCoordinate2D?
    @State var savedLocation: CLLocationCoordinate2D?
    @Binding var showPopover: Bool
    var selectedLocation: CLLocationCoordinate2D? {
        pinLocation ?? savedLocation ?? locationManager.userLocation?.coordinate
    }
    
    var onDismiss: (CLLocationCoordinate2D?) -> Void
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    if savedLocation == nil {
                        UserAnnotation()
                    }
                    if let pin = pinLocation ?? savedLocation {
                        Marker("", coordinate: pin)
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
                .onAppear {
                    if let savedLocation {
                        cameraPosition = .region(MKCoordinateRegion(center: savedLocation,
                                                                    span: .init(latitudeDelta: 0.01,
                                                                                longitudeDelta: 0.01)))
                    } else {
                        cameraPosition = .userLocation(fallback: .automatic)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                if savedLocation != nil {
                    HStack {
                        Spacer()
                        Button("Delete location") {
                           dismiss(location: nil)
                        }
                        .foregroundStyle(.red)
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        reset()
                    }
                    .disabled(pinLocation == nil)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss(location: selectedLocation)
                    }
                    .disabled(selectedLocation == nil)
                }
            }
        }
    }
    
    private func reset() {
        pinLocation = nil
        if let savedLocation {
            cameraPosition = .region(MKCoordinateRegion(center: savedLocation,
                                                        span: .init(latitudeDelta: 0.01,
                                                                    longitudeDelta: 0.01)))
        } else {
            cameraPosition = .userLocation(fallback: .automatic)
        }
    }
    
    private func dismiss(location: CLLocationCoordinate2D?) {
        showPopover = false
        onDismiss(location)
    }
}
