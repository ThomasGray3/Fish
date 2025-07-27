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
    
    init(sort: SortDescriptor<Fish>, search: String) {
        _catches = Query(filter: #Predicate {
            search.isEmpty ? true : $0.species.localizedStandardContains(search)
        }, sort: [sort])
    }

    var body: some View {
        List {
            ForEach(catches) { fish in
                Text(fish.species)
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
    CatchesListView(sort: SortDescriptor(\Fish.date), search: "")
}
