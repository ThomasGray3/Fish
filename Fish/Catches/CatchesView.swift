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
    
    private enum SortField: String, CaseIterable, Identifiable {
        case date
        case species
        case length
        case weight
        
        var id: Self { self }
        
        var label: String {
            switch self {
            case .date: "Date"
            case .species: "Species"
            case .length: "Length"
            case .weight: "Weight"
            }
        }
        
        func sortDescriptor(order: SortOrder) -> SortDescriptor<Fish> {
            switch self {
            case .date: SortDescriptor(\Fish.date, order: order)
            case .species: SortDescriptor(\Fish.species, order: order)
            case .length: SortDescriptor(\Fish.length.value, order: order)
            case .weight: SortDescriptor(\Fish.weight.value, order: order)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            CatchesListView(sort: sortField.sortDescriptor(order: sortOrder),
                            search: searchText)
            .navigationTitle("Your Catches")
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
                    Image(systemName: "arrow.up.arrow.down.circle")
                    Text(sortField.label)
                        .font(.footnote)
                }
            }
        }
    }
}

#Preview {
    CatchesView()
}
