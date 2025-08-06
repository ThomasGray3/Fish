//
//  TripsListView.swift
//  Fish
//
//  Created by Thomas Gray on 06/08/2025.
//

import SwiftUI
import SwiftData

struct TripsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var trips: [Trip]

    init(search: String) {
        _trips = Query(filter: #Predicate {
            search.isEmpty ? true : $0.name.localizedStandardContains(search)
        }, sort: [SortDescriptor(\Trip.name, order: .forward)])
    }

    var body: some View {
        if trips.isEmpty {
            Text("No trips")
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
    
    private func deleteTrip(at indexSet: IndexSet) {
        for index in indexSet {
            let trip = trips[index]
            modelContext.delete(trip)
        }
    }
}

#Preview {
    TripsListView(search: "")
}
