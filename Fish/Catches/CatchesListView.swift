//
//  CatchesListView.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import SwiftUI
import SwiftData

struct CatchesListView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var sort: SortField

    @Query private var catches: [Fish]
    
    init(sort: SortField, order: SortOrder, search: String) {
        self.sort = sort
        _catches = Query(filter: #Predicate {
            search.isEmpty ? true : $0.species.localizedStandardContains(search)
        }, sort: [sort.sortDescriptor(order: order)])
    }

    var body: some View {
        if catches.isEmpty {
            Text("No catches")
                .foregroundStyle(.gray)
        } else {
            List {
                ForEach(catches) { fish in
                    NavigationLink(value: fish) {
                        CatchListView(fish: fish, sort: sort)
                            .swipeActions(edge: .leading) {
                                Button(action: {
                                    fish.updateFavourite()
                                }) {
                                    Image(systemName: "star.fill")
                                }
                                .tint(.yellow)
                            }
                    }
                }
                .onDelete { index in
                    deleteCatch(at: index)
                }
            }
            .navigationDestination(for: Fish.self) { fish in
                FishDetailsView(fish: fish)
            }
        }
    }
    
    private func deleteCatch(at indexSet: IndexSet) {
        for index in indexSet {
            let fish = catches[index]
            modelContext.delete(fish)
        }
    }
}

#Preview {
    CatchesListView(sort: .date, order: .forward, search: "")
}
