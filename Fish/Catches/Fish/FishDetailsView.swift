//
//  FishDetailsView.swift
//  Fish
//
//  Created by Thomas Gray on 31/07/2025.
//

import SwiftUI

struct FishDetailsView: View {
    
    @State var fish: Fish
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Species
                Text(fish.species)
                    .font(.title)
                    .fontWeight(.semibold)
                
                // Date
                Text("Caught on \(fish.date.formatted())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    FishDetailsView(fish: Fish(species: "Trout",
                               length: 12.2,
                               weight: 0.5,
                               latitude: 12.0,
                               longitude: 12.4,
                               date: .now,
                               trip: nil,
                               spot: nil))
}
