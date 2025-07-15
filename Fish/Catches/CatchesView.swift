//
//  CatchesView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct CatchesView: View {
    @Environment(\.modelContext) var modelContext
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
