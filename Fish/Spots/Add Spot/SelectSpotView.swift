//
//  SelectSpotView.swift
//  Fish
//
//  Created by Thomas Gray on 06/08/2025.
//

import SwiftUI
import SwiftData

struct SelectSpotView: View {
    
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            SpotsListView(search: searchText)
                .navigationTitle("Saved Spots")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText,
                            placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

#Preview {
    SelectSpotView()
}
