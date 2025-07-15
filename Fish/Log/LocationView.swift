//
//  LocationView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI

struct LocationView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            MapView()
            .navigationTitle("Add Location")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search location")
        }
    }
}

#Preview {
    LocationView()
}
