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
    
    @Query
    private var trips: [Trip]
    
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
                    }
                }
            }
            .navigationTitle("Trips")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        // Your action here (e.g. show sheet to add trip)
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    TripsView()
}
