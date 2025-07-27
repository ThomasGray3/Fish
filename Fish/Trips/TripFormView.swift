//
//  TripFormView.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import SwiftUI

struct TripFormView: View {
    
    @State private var name: Double?
    @State private var latitude: Double?
    @State private var longitude: Double?
    @State private var date: Date = Date()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TripFormView()
}
