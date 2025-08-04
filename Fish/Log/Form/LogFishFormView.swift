//
//  LogFishFormView.swift
//  Fish
//
//  Created by Thomas Gray on 28/07/2025.
//

import SwiftUI
import MapKit
import SwiftData

struct LogFishFormView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var suggestedTrips: [Trip] = []
    @State var viewModel: LogFishFormViewModel
    @State private var showPopover = false
    
    var body: some View {
        Form {
            Section(header: Text("Fish Data")) {
                // Species
                TextField("Species", text: $viewModel.species)
                // Length
                HStack {
                    Text("Length")
                    Spacer()
                    TextField("Enter length",
                              value: $viewModel.length,
                              format: .number.precision(.fractionLength(2)),
                              prompt: Text("0.0"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 10)
                }
                // Weight
                HStack {
                    Text("Weight")
                    Spacer()
                    TextField("Enter weight",
                              value: $viewModel.weight,
                              format: .number.precision(.fractionLength(2)),
                              prompt: Text("0.0"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 10)
                }
            }
            
            // Location
            Section(header: Text("Location")) {
                HStack {
                    Button("Location") {
                        showPopover.toggle()
                    }.sheet(isPresented: $showPopover) {
                        LocationView(pinLocation: viewModel.location) { location in
                            viewModel.updateLocation(pinLocation: location)
                        }
                    }
                    if viewModel.location != nil {
                        TextField(viewModel.locationDefaultName,
                                  text: $viewModel.locationName)
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.trailing)
                    }
                }
                if viewModel.location != nil {
                    Toggle("Save location", isOn: $viewModel.saveLocation)
                }
            }

            // Date
            Section(header: Text("Date")) {
                DatePicker("Date Caught",
                           selection: $viewModel.date,
                           displayedComponents: [.date, .hourAndMinute])
                if !suggestedTrips.isEmpty {
                    Picker("Suggested Trip", selection: $viewModel.selectedTrip) {
                        Text("None").tag(Optional<Trip>(nil))
                        ForEach(suggestedTrips) { trip in
                            Text(trip.name).tag(trip)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }

            // Submit
            Section {
                Button("Save Catch") {
                    viewModel.submitForm(modelContext: modelContext)
                }
                .disabled(!viewModel.formValid)
            }
        }
        .onChange(of: viewModel.date) {
            loadSuggestedTrips()
        }
        .onAppear {
            loadSuggestedTrips()
        }
    }
    
    private func loadSuggestedTrips() {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -1, to: viewModel.date)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: viewModel.date)!

        let predicate = #Predicate<Trip> { trip in
            trip.startDate <= endDate && trip.endDate >= startDate
        }
        
        do {
            suggestedTrips = try modelContext.fetch(FetchDescriptor(predicate: predicate))
        } catch {
            suggestedTrips = []
        }
    }
}

#Preview {
    LogFishFormView(viewModel: LogFishFormViewModel())
}
