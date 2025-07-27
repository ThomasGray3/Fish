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
    @State private var sortField = SortDescriptor(\Fish.date)
    @State private var sortOrder: SortOrder = .forward
    @Query private var catches: [Fish]
    
    init(sort: SortDescriptor<Fish>) {
        _catches = Query(sort: [sort])
    }
    
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
                    Picker("Sort", selection: $sortField) {
                        Text("Date")
                            .tag(SortDescriptor(\Fish.date))
                        Text("Name")
                            .tag(SortDescriptor(\Fish.species))
                        Text("Length")
                            .tag(SortDescriptor(\Fish.length))
                        Text("Weight")
                            .tag(SortDescriptor(\Fish.weight))
                    }
                    .pickerStyle(.inline)
                    
                    Divider()
                    Button(sortOrder == .reverse ? "Descending" : "Ascending") {
                        
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
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
    CatchesView(sort: SortDescriptor(\Fish.date))
}
