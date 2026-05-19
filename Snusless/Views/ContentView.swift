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
                OnboardingNameView()
            case .userCreated:
                // Change to HomeView, just put this to be able to compile app. 
                OnboardingNameView()
            }
        }
        .environment(onboardingViewModel)
        
    }
}

#Preview {
    ContentView()
}
