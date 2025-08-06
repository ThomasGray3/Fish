//
//  TripsView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct TripsView: View {

    @State private var showPopover = false
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            TripsListView(search: searchText)
            .navigationTitle("Trips")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showPopover.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showPopover) {
                TripFormView(viewModel: TripFormViewModel())
            }
        }
    }
}

#Preview {
    TripsView()
}
