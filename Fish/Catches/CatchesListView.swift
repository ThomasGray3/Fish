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
    @Query private var catches: [Fish]
    @State private var sort: SortField
    
    init(sort: SortField, order: SortOrder, search: String) {
        self.sort = sort
        _catches = Query(filter: #Predicate {
            search.isEmpty ? true : $0.species.localizedStandardContains(search)
        }, sort: [sort.sortDescriptor(order: order)])
    }

    var body: some View {
        List {
            ForEach(catches) { fish in
                CatchListView(fish: fish, sort: sort)
            }
            .onDelete { index in
                deteleCatch(at: index)
            }
        }
    }
    
    private func deteleCatch(at indexSet: IndexSet) {
        for index in indexSet {
            let fish = catches[index]
            modelContext.delete(fish)
        }
    }
}

#Preview {
    CatchesListView(sort: .date, order: .forward, search: "")
}
