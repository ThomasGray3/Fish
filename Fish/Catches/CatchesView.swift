//
//  CatchesView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct CatchesView: View {
    
    @State private var sortField: SortField = .date
    @State private var sortOrder: SortOrder = .forward
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            CatchesListView(sort: sortField,
                            order: sortOrder,
                            search: searchText)
            .navigationTitle("Catch log")
            .searchable(text: $searchText)
            .toolbar {
                Menu {
                    Picker("Sort", selection: $sortField) {
                        ForEach(SortField.allCases) { field in
                            Text(field.label).tag(field)
                        }
                    }
                    .pickerStyle(.inline)
                    
                    Divider()
                    Button(sortOrder == .forward ? "Descending" : "Ascending") {
                        sortOrder = sortOrder == .forward ? .reverse : .forward
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
        }
    }
}

#Preview {
    CatchesView()
}
