//
//  SpotsView.swift
//  Fish
//
//  Created by Thomas Gray on 04/08/2025.
//

import SwiftUI
import SwiftData

struct SpotsView: View {

    @Environment(\.modelContext) var modelContext
    @Query var spots: [Spot] = []
    @State var showPopover = false

    var body: some View {
        NavigationStack {
            Group {
                if spots.isEmpty {
                    Text("No spots yet")
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
            .navigationTitle("Spots")
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
                AddSpotView() { spot in
                    if let spot {
                        modelContext.insert(spot)
                    }
                }
            }
        }
    }
    
    private func deleteSpot(at indexSet: IndexSet) {
        for index in indexSet {
            let trip = spots[index]
            modelContext.delete(trip)
        }
    }
}

#Preview {
    SpotsView()
        .environment(LocationManager())
}
