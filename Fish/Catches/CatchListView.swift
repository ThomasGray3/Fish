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
                
                if let weight = fish.weight.value {
                    DetailsView(imageName: "scalemass", detailText: weight.toString())
                }
                if let length = fish.length.value {
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
                             length: Fish.Measurement(value: 50.4, unit: .cm),
                             weight: Fish.Measurement(value: 6, unit: .lbs),
                             latatude: nil,
                             longitude: nil,
                             date: Date()),
                  sort: .weight)
}
