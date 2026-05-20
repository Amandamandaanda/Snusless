//
//  SnuslessApp.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-13.
//

import SwiftUI
import SwiftData

@main
struct SnuslessApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self])
    }
}
