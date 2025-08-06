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
    @State private var showPopover = false
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            SpotsListView(search: searchText)
            .navigationTitle("Spots")
            .searchable(text: $searchText)
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
}

#Preview {
    SpotsView()
        .environment(LocationManager())
}
