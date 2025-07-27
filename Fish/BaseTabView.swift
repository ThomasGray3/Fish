//
//  BaseTabView.swift
//  Fish
//
//  Created by Thomas Gray on 14/07/2025.
//

import SwiftUI

struct BaseTabView: View {
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Explore")
                }
            LogFishView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Log Catch")
                }
            CatchesView(sort: SortDescriptor(\Fish.date))
                .tabItem {
                    Image(systemName: "fish")
                    Text("Catches")
                }
            TripsView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Trips")
                }
        }
    }
}

#Preview {
    BaseTabView()
}
