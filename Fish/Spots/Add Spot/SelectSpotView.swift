//
//  SelectSpotView.swift
//  Fish
//
//  Created by Thomas Gray on 06/08/2025.
//

import SwiftUI
import SwiftData

struct SelectSpotView: View {
   
    @Query var spots: [Spot] = []
    @Query(sort: [SortDescriptor(\Spot.name)]) private var allSpots: [Spot]
    @State private var searchText: String = ""
    
    var onTap: (Spot?) -> Void
    
    private var filteredSpots: [Spot] {
        searchText.isEmpty ? allSpots : allSpots.filter { $0.name.localizedStandardContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredSpots) { spot in
                HStack {
                    Text(spot.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onTap(spot)
                }
            }
            .navigationTitle("Saved Spots")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
