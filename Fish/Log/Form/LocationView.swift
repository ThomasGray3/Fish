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
    @Environment(\.dismiss) var dismiss

    @State var cameraPosition: MapCameraPosition = .automatic
    @State var pinLocation: CLLocationCoordinate2D?
    @State var savedLocation: CLLocationCoordinate2D?
    @State var disabledPins: [CLLocationCoordinate2D] = []
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
                    if !disabledPins.isEmpty {
                        ForEach(disabledPins.indices, id: \.self) { index in
                            if (disabledPins[index].latitude != savedLocation?.latitude
                                && disabledPins[index].longitude != savedLocation?.longitude) {
                                Marker("Location \(index + 1)", coordinate: disabledPins[index])
                                    .tint(.gray)
                            }
                        }
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
                   reset()
                }
            }
            .safeAreaInset(edge: .bottom) {
                if savedLocation != nil {
                    HStack {
                        Spacer()
                        Button("Delete location") {
                            close(location: nil)
                        }
                        .foregroundStyle(.red)
                        Spacer()
                    }
                    .padding(.top)
                    .background(.thinMaterial)
                    .transition(.opacity)
                }
            }
            .navigationTitle(savedLocation == nil ? "Add Location" : "Edit Location")
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
                        close(location: selectedLocation)
                    }
                    .disabled(selectedLocation == nil)
                }
            }
        }
    }
    
    private func reset() {
        pinLocation = nil
        if !disabledPins.isEmpty {
            cameraPosition = .automatic
        } else if let savedLocation {
            cameraPosition = .region(MKCoordinateRegion(center: savedLocation,
                                                        span: .init(latitudeDelta: 0.1,
                                                                    longitudeDelta: 0.1)))
        } else {
            cameraPosition = .userLocation(fallback: .automatic)
        }
    }
    
    private func close(location: CLLocationCoordinate2D?) {
        onDismiss(location)
        dismiss()
    }
}
