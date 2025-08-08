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
    @State private var showPopover = true
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var spotName = ""
    @State private var sheetPosition: PresentationDetent = .height(115)
    var selectedLocation: CLLocationCoordinate2D? {
        spot?.location.coordinate ?? locationManager.userLocation?.coordinate
    }
    
    var onDismiss: (Spot?) -> Void
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    if spot == nil {
                        UserAnnotation()
                    }
                    if let spot {
                        Marker(spot.name.isEmpty ? "New Marker" : spot.name,
                               coordinate: spot.location.coordinate)
                    }
                }
                .mapControls {
                    MapCompass()
                    MapUserLocationButton()
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let pinLocation = coordinate
                        spot = Spot(name: "",
                                    latitude: pinLocation.latitude,
                                    longitude: pinLocation.longitude)
                    }
                }
            }
            .sheet(isPresented: $showPopover) {
                SelectSpotView() { savedSpot in
                    spot = savedSpot
                    resetCamera()
                }
                    .presentationDetents([.height(115), .medium, .large], selection: $sheetPosition)
                    .presentationBackgroundInteraction(.enabled)
                    .presentationCornerRadius(20)
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
            }
            .onAppear {
                resetCamera()
            }
            .alert("New Spot", isPresented: $showAlert) {
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
                Button("Cancel", role: .cancel) {
                    showPopover = true
                }
            }
            .navigationTitle("Select Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Select") {
                        if let spot, !spot.name.isEmpty {
                            close(spot: spot)
                        } else {
                            showAlert = true
                        }
                    }
                    .disabled(selectedLocation == nil)
                }
            }
        }
    }
    
    private func resetCamera() {
        withAnimation {
            sheetPosition = .height(115)
            if let spot {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    )
                )
            } else {
                cameraPosition = .userLocation(fallback: .automatic)
            }
        }
    }
    
    private func close(spot: Spot?) {
        onDismiss(spot)
        dismiss()
    }
}
