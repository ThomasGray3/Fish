//
//  TripsView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct TripsView: View {
    
    @Environment(\.modelContext) var modelContext
    @State var showPopover = false
    @Query private var trips: [Trip]
    
    var body: some View {
        NavigationStack {
            Group {
                if trips.isEmpty {
                    Text("No trips yet")
                        .foregroundStyle(.gray)
                } else {
                    List {
                        ForEach(trips) { trip in
                            Text(trip.name)
                        }
                        .onDelete { index in
                            deleteTrip(at: index)
                        }
                    }
                }
            }
            .navigationTitle("Trips")
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
    
    private func deleteTrip(at indexSet: IndexSet) {
        for index in indexSet {
            let trip = trips[index]
            modelContext.delete(trip)
        }
    }
}

#Preview {
    TripsView()
}
