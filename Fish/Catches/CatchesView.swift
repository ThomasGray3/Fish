//
//  CatchesView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct CatchesView: View {

    enum SortField: String, CaseIterable {
        case date = "Date"
        case species = "Species"
        case length = "Length"
        case weight = "Weight"
    }
    
    @Environment(\.modelContext) var modelContext
    @State private var selectedSortField: SortField = .date
    @State private var sortAscending: Bool = true
    @Query var catches: [Fish]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(catches) { fish in
                    Text(fish.species)
                }
                .onDelete { index in
                    deteleCatch(at: index)
                }
            }
            .navigationTitle("Your Catches")
            .toolbar {
                Menu {
                    ForEach(SortField.allCases, id: \.self) { field in
                        Button {
                            selectedSortField = field
                        } label: {
                            Label("Sort by \(field.rawValue)", systemImage: sortIcon(for: field))
                        }
                    }
                    
                    Divider()
                    Button(sortAscending ? "Descending" : "Ascending") {
                        sortAscending.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                    Text(selectedSortField.rawValue)
                }
            }
        }
    }
    
    
    private func sortIcon(for field: SortField) -> String {
        switch field {
        case .species: return "fish"
        case .length: return "ruler"
        case .weight: return "scalemass"
        case .date: return "calendar"
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
    CatchesView()
}
