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
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Add Trip")) {
                    // Species
                    TextField("Name", text: $viewModel.name)
                    // Location
                    HStack {
                        Button("Location") {
                            showPopover.toggle()
                        }.sheet(isPresented: $showPopover) {
                            LocationView(savedLocation: viewModel.location,
                                         showPopover: $showPopover) { location in
                                viewModel.location = location
                            }
                        }
                        Spacer()
                        if viewModel.location != nil {
                            Text("Marked location")
                        }
                    }
                    // Date
                    DatePicker("Date",
                               selection: $viewModel.date,
                               displayedComponents: [.date, .hourAndMinute])
                }
                // Submit
                Section {
                    Button("Save Catch") {
                        viewModel.submitForm(modelContext: modelContext)
                        showPopover = false
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
