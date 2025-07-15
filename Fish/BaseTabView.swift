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
            EmptyView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Explore")
                }
            EmptyView()
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("Identify Fish")
                }
            LogFishView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Log Catch")
                }
            CatchesView()
                .tabItem {
                    Image(systemName: "fish")
                    Text("Your Catches")
                }
        }
    }
}

#Preview {
    BaseTabView()
}
