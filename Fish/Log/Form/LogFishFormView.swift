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
                    TextField("",
                              value: $viewModel.length,
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
                              value: $viewModel.weight,
                              format: .number,
                              prompt: Text("0.0"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 10)
                }
                // Location
                HStack {
                    Button("Location") {
                        showPopover.toggle()
                    }.sheet(isPresented: $showPopover) {
                        LocationView(savedLocation: viewModel.location) { location in
                            viewModel.location = location
                        }
                    }
                    Spacer()
                    if viewModel.location != nil {
                        Text("Marked location")
                    }
                }
                // Date
                DatePicker("Date Caught",
                           selection: $viewModel.date,
                           displayedComponents: [.date, .hourAndMinute])
            }
            
            if !suggestedTrips.isEmpty {
                Section(header: Text("Are you on a planned trip?")) {
                    Picker("Trip", selection: $viewModel.selectedTrip) {
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
