//
//  CatchListView.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import SwiftUI

struct CatchListView: View {
    
    @State var fish: Fish
    @State var sort: SortField
    
    var body: some View {
        HStack {
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading) {
                    Text(fish.species)
                    Text(fish.date.string ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                Spacer()
                
                if let weight = fish.weight {
                    DetailsView(imageName: "scalemass", detailText: weight.toString())
                }
                if let length = fish.length {
                    DetailsView(imageName: "ruler", detailText: length.toString())
                }
            }

            if fish.favourite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
    
    private struct DetailsView: View {
        var imageName: String
        var detailText: String
        
        var body: some View {
            VStack {
                Image(systemName: imageName)
                Text(detailText)
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    CatchListView(fish: Fish(species: "Trout",
                             length: 50.4,
                             weight: 6.3,
                             latitude: nil,
                             longitude: nil,
                             date: Date(),
                             trip: nil),
                  sort: .weight)
}
