//
//  CatchesView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct CatchesView: View {

    @State private var sortField = SortDescriptor(\Fish.date)
    @State private var sortOrder: SortOrder = .forward
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            CatchesListView(sort: sortField, search: searchText)
            .navigationTitle("Your Catches")
            .searchable(text: $searchText)
            .toolbar {
                Menu("", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortField) {
                        Text("Date")
                            .tag(SortDescriptor(\Fish.date))
                        Text("Species")
                            .tag(SortDescriptor(\Fish.species))
                        Text("Length")
                            .tag(SortDescriptor(\Fish.length.value))
                        Text("Weight")
                            .tag(SortDescriptor(\Fish.weight.value))
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
}

#Preview {
    CatchesView()
}
