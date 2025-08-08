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
    @State var viewModel: LogFishFormViewModel
    @State private var suggestedTrips: [Trip] = []
    @State private var showAddSpotSheet = false

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
                HStack {
                    if let spot = viewModel.spot {
                        Text(spot.name)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    Button(viewModel.spot == nil ? "Add Spot" : "Edit Spot") {
                        showAddSpotSheet.toggle()
                    }.fullScreenCover(isPresented: $showAddSpotSheet) {
                        AddSpotView(spot: viewModel.spot) { spot in
                            if let spot {
                                viewModel.spot = spot
                            }
                        }
                    }
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
