//
//  SpotsListView.swift
//  Fish
//
//  Created by Thomas Gray on 06/08/2025.
//

import SwiftUI
import SwiftData

struct SpotsListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var spots: [Spot] = []

    init(search: String) {
        _spots = Query(filter: #Predicate {
            search.isEmpty ? true : $0.name.localizedStandardContains(search)
        }, sort: [SortDescriptor(\Spot.name, order: .forward)])
    }

    var body: some View {
        if spots.isEmpty {
            Text("No spots")
                .foregroundStyle(.gray)
        } else {
            List {
                ForEach(spots) { trip in
                    Text(trip.name)
                }
                .onDelete { index in
                    deleteSpot(at: index)
                }
            }
        }
    }
    
    private func deleteSpot(at indexSet: IndexSet) {
        for index in indexSet {
            let spot = spots[index]
            modelContext.delete(spot)
        }
    }
}

#Preview {
    SpotsListView(search: "")
}
