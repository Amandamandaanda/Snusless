//
//  ContentView.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-05-13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        NavigationStack {
            switch onboardingViewModel.userState {
            case .notCreated:
                OnboardingView()
            case .userCreated:
                HomeView()
            }
        }
        .environment(onboardingViewModel)
        
    }
}

#Preview {
    ContentView()
}
