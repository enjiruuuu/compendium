//
//  ContentView.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        ListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
