//
//  ContentView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-13.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var onboardingViewModel = OnboardingViewModel()
    @Query private var users: [User]
    
    var body: some View {
        Group {
            if users.isEmpty {
                OnboardingView()
            } else {
                HomeView()
            }
        }
        .environment(onboardingViewModel)
    }
}

#Preview {
    ContentView()
        .environment(OnboardingViewModel())
        .modelContainer(for: User.self, inMemory: true)
}
