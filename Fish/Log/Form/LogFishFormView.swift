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
    @Environment(LocationManager.self) var locationManager
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Spot.name)]) var spots: [Spot]
    @State private var suggestedTrips: [Trip] = []
    @State var viewModel: LogFishFormViewModel
    @State private var showPopover = false
    private var showSpotPicker: Bool {
        viewModel.newSpot == nil
    }
    private var sortedSpots: [Spot] {
        spots.sorted {
            if let userLocation = locationManager.userLocation {
                return ($0.location.distance(from: userLocation)
                        < $1.location.distance(from: userLocation))
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Fish Data")) {
                // Species
                TextField("Species", text: $viewModel.species)
                // Length
                HStack {
                    Text("Length")
                    Spacer()
                    TextField("Enter Length",
                              value: $viewModel.length,
                              format: .number.precision(.fractionLength(2)),
                              prompt: Text("0.0"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal, 10)
                }
                // Weight
                HStack {
                    Text("Weight")
                    Spacer()
                    TextField("Enter Weight",
                              value: $viewModel.weight,
                              format: .number.precision(.fractionLength(2)),
                              prompt: Text("0.0"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal, 10)
                }
            }
            
            // Spot
            Section(header: Text("Spot")) {
                if showSpotPicker {
                    Picker("Spot", selection: $viewModel.existingSpot) {
                        Text("None").tag(Optional<Spot>(nil))
                        ForEach(sortedSpots) { spot in
                            HStack {
                                Text(spot.name)
                                if let location = locationManager.userLocation {
                                    Spacer()
                                    Text(spot.distanceTo(userLocation: location).toString() + "km")
                                        .foregroundStyle(.gray)
                                        .font(.footnote)
                                }
                            }
                            .tag(spot)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                // New Spot
                Button(showSpotPicker
                       ? "Add New Spot"
                       : viewModel.newSpot?.name ?? "New Spot") {
                    showPopover.toggle()
                }.sheet(isPresented: $showPopover) {
                    AddSpotView(spot: viewModel.newSpot) { spot in
                        viewModel.newSpot = spot
                    }
                }
                if !showSpotPicker {
                    Toggle("Save Location", isOn: $viewModel.saveLocation)
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
        guard let startDate = calendar.date(byAdding: .day, value: -1, to: viewModel.date),
              let endDate = calendar.date(byAdding: .day, value: 1, to: viewModel.date) else {
            return suggestedTrips = []
        }
        
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
