//
//  LogFishView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import MapKit
import SwiftData
import CoreLocationUI

struct LogFishView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showLocationPopover = false
    @State private var species: String = ""
    @State private var length: Double?
    @State private var weight: Double?
    @State private var location: CLLocationCoordinate2D?
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Fish Data")) {
                    // Species
                    TextField("Species", text: $species)
                    // Length
                    HStack {
                        Text("Length")
                        Spacer()
                        TextField("",
                                  value: $length,
                                  format: .number,
                                  prompt: Text("0.0"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                    }
                    // Weight
                    HStack {
                        Text("Weight")
                        Spacer()
                        TextField("",
                                  value: $weight,
                                  format: .number,
                                  prompt: Text("0.0"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                    }
                    // Location
                    HStack {
                        Button("Location") {
                            showLocationPopover.toggle()
                        }.popover(isPresented: $showLocationPopover) {
                            LocationView(showPopover: $showLocationPopover) { location in
                                self.location = location
                            }
                        }
                        Spacer()
                        if location != nil {
                            Text("Marked location")
                        }
                    }
                    // Date
                    DatePicker("Date Caught",
                               selection: $date,
                               displayedComponents: [.date, .hourAndMinute])
                }
                // Submit
                Section {
                    Button("Save Catch") {
                        submitForm()
                    }
                    .disabled(species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    
                }
            }
            .navigationTitle("Log Your Catch")
        }
    }
    
    private func submitForm() {
        modelContext.insert(
            Fish(species: species,
                 length: length,
                 weight: weight,
                 latatude: location?.latitude,
                 longitude: location?.longitude,
                 date: date,
                 trip: nil))
        resetForm()
    }
    
    private func resetForm() {
        species = ""
        length = nil
        weight = nil
        location = nil
        date = Date()
    }
}

#Preview {
    LogFishView()
        .environment(LocationManager())
}
