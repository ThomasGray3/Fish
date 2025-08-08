//
//  TripFormView.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import SwiftUI


struct TripFormView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var viewModel: TripFormViewModel
    @State private var showPopover = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Create Trip")) {
                    // Name
                    TextField("Trip Name", text: $viewModel.name)
                    // Date
                    DatePicker("Start Date",
                               selection: $viewModel.startDate,
                               in: viewModel.startDate...,
                               displayedComponents: .date)
                    DatePicker("End Date",
                               selection: $viewModel.endDate,
                               in: viewModel.startDate...,
                               displayedComponents: .date)
                }
                // Spots
                Section(header: Text("Spot")) {
                    ForEach(viewModel.spots) { spot in
                        Text(spot.name)
                    }
                    .onDelete { index in
                        viewModel.spots.remove(atOffsets: index)
                    }
                    Button("Add Spot") {
                        showPopover.toggle()
                    }.sheet(isPresented: $showPopover) {
                        AddSpotView() { spot in
                            if let spot {
                                viewModel.spots.append(spot)
                            }
                        }
                    }
                }
                // Colour
                Section(header: Text("Pick a Colour")) {
                    ColorPicker("Event Colour",
                                selection: $viewModel.selectedColor,
                                supportsOpacity: false)
                }
                
                // Submit
                Section {
                    Button("Create Trip") {
                        viewModel.submitForm(modelContext: modelContext)
                        dismiss()
                    }
                    .disabled(!viewModel.formValid)
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
