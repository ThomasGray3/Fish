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
            FirstView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Explore")
                }
            FirstView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Log Catch")
                }
            FirstView()
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("Scan")
                }
            FirstView()
                .tabItem {
                    Image(systemName: "fish")
                    Text("Database")
                }
        }
    }
}

struct FirstView: View {
    var body: some View {
        NavigationView {
            Text("Home Screen")
                .navigationTitle("Home")
        }
    }
}

#Preview {
    BaseTabView()
}
