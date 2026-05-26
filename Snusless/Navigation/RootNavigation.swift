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
    
    @Binding var selectedTab: TabSelection
    
    var body: some View {
        Group {
            if users.isEmpty {
                OnboardingNavigation()
            } else {
                TabNavigation(selectedTab: $selectedTab)
            }
        }
        .environment(onboardingViewModel)
    }
}

#Preview {
    RootNavigation( selectedTab: .constant(.home))
        .environment(OnboardingViewModel())
        .modelContainer(for: User.self, inMemory: true)
}
