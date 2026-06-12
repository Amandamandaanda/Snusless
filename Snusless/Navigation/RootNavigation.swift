//
//  ContentView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-13.
//

import SwiftUI
import SwiftData

struct RootNavigation: View {
    @State private var onboardingViewModel = OnboardingViewModel()
    @Query private var users: [User]
    
    
    var body: some View {
        Group {
            if users.isEmpty {
                OnboardingNavigation()
            } else {
                TabNavigation()
            }
        }
        .environment(onboardingViewModel)
    }
}

#Preview("Swedish") {
    RootNavigation()
        .environment(OnboardingViewModel())
        .modelContainer(for: User.self, inMemory: true)
}

#Preview("English") {
    RootNavigation()
        .environment(OnboardingViewModel())
        .environment(\.locale, Locale(identifier: "ENG"))
        .modelContainer(for: User.self, inMemory: true)
}
