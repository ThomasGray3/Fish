//
//  TripFormView.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import SwiftUI


struct TripFormView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State var viewModel: TripFormViewModel
    @State var showPopover = false
    @State private var activeSheet: ActiveSheet?
    
    enum ActiveSheet: Identifiable {
        case editLocation(index: Int)
        case addLocation
        
        var id: String {
            switch self {
            case .editLocation(let index):
                return "edit_\(index)"
            case .addLocation:
                return "add"
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Create Trip")) {
                    // Species
                    TextField("Trip Name", text: $viewModel.name)
                    // Location
                    ForEach(viewModel.locations.indices, id: \.self) { index in
                        HStack {
                            Button("Location \(index + 1)") {
                                activeSheet = .editLocation(index: index)
                            }
                            Spacer()
                            Text("Marked location")
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.locations.remove(atOffsets: indexSet)
                    }
                    
                    Button {
                        activeSheet = .addLocation
                    } label: {
                        Label("Add Stop", systemImage: "plus.circle")
                    }
                    // Date
                    DatePicker("Start Date",
                               selection: $viewModel.startDate,
                               displayedComponents: [.date])
                    DatePicker("End Date",
                               selection: $viewModel.endDate,
                               in: viewModel.startDate..., displayedComponents: .date)
                }
                Section(header: Text("Pick a Colour")) {
                    ColorPicker("Event Colour",
                                selection: $viewModel.selectedColor,
                                supportsOpacity: false)
                }
                
                // Submit
                Section {
                    Button("Create Trip") {
                        viewModel.submitForm(modelContext: modelContext)
                        showPopover = false
                    }
                    .disabled(!viewModel.formValid)
                }
            }
            .sheet(item: $activeSheet) { sheet in
                    switch sheet {
                    case .editLocation(let index):
                        LocationView(savedLocation: viewModel.locations[index],
                                     disabledPins: viewModel.locations) { location in
                            if let location {
                                viewModel.locations[index] = location
                            } else {
                                viewModel.locations.remove(at: index)
                            }
                        }

                    case .addLocation:
                        LocationView(disabledPins: viewModel.locations) { location in
                            if let location {
                                viewModel.locations.append(location)
                            }
                        }
                    }
                }
            .navigationTitle("Add trip")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TripFormView(viewModel: TripFormViewModel())
        .environment(LocationManager())
}
