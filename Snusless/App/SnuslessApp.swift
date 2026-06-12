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
            LaunchView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [User.self, Streak.self])
    }
}
