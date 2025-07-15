//
//  FishApp.swift
//  Fish
//
//  Created by Thomas Gray on 14/07/2025.
//

import SwiftUI
import SwiftData

@main
struct FishApp: App {
    var body: some Scene {
        WindowGroup {
            BaseTabView()
        }
        .modelContainer(for: Fish.self)
    }
}
