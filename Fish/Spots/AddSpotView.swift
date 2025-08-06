//
//  AddSpotView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import MapKit

struct AddSpotView: View {
    @Environment(LocationManager.self) var locationManager
    @Environment(\.dismiss) var dismiss

    @State var spot: Spot?
    @State private var showAlert = false
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var pinLocation: CLLocationCoordinate2D?
    @State private var spotName = ""
    var selectedLocation: CLLocationCoordinate2D? {
        pinLocation ?? locationManager.userLocation?.coordinate
    }
    
    var onDismiss: (Spot?) -> Void
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    if spot == nil {
                        UserAnnotation()
                    }
                    if let pin = pinLocation {
                        Marker("", coordinate: pin)
                    } else if let spot {
                        Marker(spot.name, coordinate: spot.location.coordinate)
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
            .onAppear {
                reset()
            }
            .alert("Name This Spot", isPresented: $showAlert) {
                TextField("Enter a name",
                          text: $spotName)
                Button("Save") {
                    if let selectedLocation {
                        let spot = Spot(name: spotName,
                                        latitude: selectedLocation.latitude,
                                        longitude: selectedLocation.longitude)
                        close(spot: spot)
                    }
                }
                .disabled(spotName.isEmpty)
                Button("Cancel", role: .cancel) {}
            }
            .navigationTitle(spot == nil ? "Add Location" : "Edit Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        reset()
                    }
                    .disabled(pinLocation == nil)
                }
                if spot != nil {
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Delete") {
                            close(spot: nil)
                        }
                        .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        showAlert = true
                    }
                    .disabled(selectedLocation == nil)
                }
            }
        }
    }
    
    private func reset() {
        withAnimation {
            if let spot {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
            } else {
                pinLocation = nil
                cameraPosition = .userLocation(fallback: .automatic)
            }
        }
    }
    
    private func close(spot: Spot?) {
        onDismiss(spot)
        dismiss()
    }
}
