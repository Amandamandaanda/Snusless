//
//  OnboardingView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-19.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    
    var body: some View {
        ZStack {
            switch onboardingViewModel.onboardingState {
            case .onboardingName:
                OnboardingNameView()
                    .transition(.move(edge: .leading))
            case .onboardingDate:
                OnboardingDateView()
                    .transition(.move(edge: .trailing))
            case .onboardingDone:
                HomeView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.smooth(duration: 0.3), value: onboardingViewModel.onboardingState)
    }
}

#Preview {
    OnboardingView()
        .environment(OnboardingViewModel())
}
