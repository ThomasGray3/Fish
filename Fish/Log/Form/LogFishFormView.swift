//
//  LogFishFormView.swift
//  Fish
//
//  Created by Thomas Gray on 28/07/2025.
//

import SwiftUI
import MapKit

struct LogFishFormView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State var viewModel: LogFishFormViewModel
    @State private var showLocationPopover = false
    
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
                        showLocationPopover.toggle()
                    }.sheet(isPresented: $showLocationPopover) {
                        LocationView(savedLocation: viewModel.location,
                                     showPopover: $showLocationPopover) { location in
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
            // Submit
            Section {
                Button("Save Catch") {
                    viewModel.submitForm(modelContext: modelContext)
                }
                .disabled(!viewModel.formValid)
                
            }
        }
    }
}

#Preview {
    LogFishFormView(viewModel: LogFishFormViewModel())
}
