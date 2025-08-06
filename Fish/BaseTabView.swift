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
            LogFishView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Log Catch")
                }
            CatchesView()
                .tabItem {
                    Image(systemName: "fish")
                    Text("Catches")
                }
            ExploreView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Explore")
                }
            SpotsView()
                .tabItem {
                    Image(systemName: "mappin")
                    Text("Spots")
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
        .environment(LocationManager())
}
