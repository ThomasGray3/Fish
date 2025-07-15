//
//  CatchesView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI
import SwiftData

struct CatchesView: View {
    @Query var catches: [Fish]

       var body: some View {
           NavigationView {
               List {
                   ForEach(catches) { fish in
                       Text(fish.species)
                   }
                   .onDelete { index in
                       
                   }
               }
               .navigationTitle("Your Catches")
           }
       }
   }

#Preview {
    CatchesView()
}
