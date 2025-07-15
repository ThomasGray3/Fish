//
//  LogFishView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData
import CoreLocationUI

struct LogFishView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showLocationPopover = false
    @State private var species: String = ""
    @State private var length: Fish.Measurement = .init(value: nil, unit: .cm)
    @State private var weight: Fish.Measurement = .init(value: nil, unit: .lbs)
    @State private var location: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Fish Data")) {
                        // Species
                        TextField("Species", text: $species)
                        // Length
                        HStack {
                            Text("Length")
                            Spacer()
                            TextField("0.0",
                                      value: $length.value,
                                      format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 10)
                            Picker("", selection: $length.unit) {
                                Text(Fish.Unit.cm.rawValue).tag(Fish.Unit.cm)
                                Text(Fish.Unit.inch.rawValue).tag(Fish.Unit.inch)
                            }
                            .pickerStyle(.segmented)
                        }
                        // Weight
                        HStack {
                            Text("Weight")
                            Spacer()
                            TextField("",
                                      value: $weight.value,
                                      format: .number,
                                      prompt: Text("0.0"))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 10)
                            Picker("", selection: $weight.unit) {
                                Text(Fish.Unit.lbs.rawValue).tag(Fish.Unit.lbs)
                                Text(Fish.Unit.kg.rawValue).tag(Fish.Unit.kg)
                            }
                            .pickerStyle(.segmented)
                        }
                        // Location
                        HStack {
                            Button("Location") {
                                showLocationPopover.toggle()
                            }.popover(isPresented: $showLocationPopover) {
                                LocationView()
                            }
                        }
                        // Date
                        DatePicker("Date Caught",
                                   selection: $date,
                                   displayedComponents: [.date,
                                                         .hourAndMinute])
                        
                    }
                    Section {
                        Button("Save Catch") {
                            modelContext.insert(
                                Fish(species: species,
                                     length: length,
                                     weight: weight,
                                     location: location,
                                     date: date))
                        }
                        .disabled(species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        
                    }
                }
                .navigationTitle("Log Your Catch")
            }
        }
    }
}

#Preview {
    LogFishView()
}
