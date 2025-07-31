//
//  LogFishView.swift
//  Fish
//
//  Created by Thomas Gray on 15/07/2025.
//

import SwiftUI

struct LogFishView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            LogFishFormView(viewModel: LogFishFormViewModel())
            .navigationTitle("Log Your Catch")
        }
    }
}

#Preview {
    LogFishView()
        .environment(LocationManager())
}
