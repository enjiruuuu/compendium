//
//  ListView.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    ItemDetailView()
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.pink)
                    Text("Thresher Shark")
                }
            }
        } detail: {
            Text("Test")
        }
    }
}

#Preview {
    ListView()
}
