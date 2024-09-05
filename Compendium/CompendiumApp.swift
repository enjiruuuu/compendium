//
//  CompendiumApp.swift
//  Compendium
//
//  Created by Angel on 4/9/24.
//

import SwiftUI
import SwiftData

@main
struct CompendiumApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
