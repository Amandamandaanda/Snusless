//
//  OnboardingNavigationTabView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-06-11.
//

import SwiftUI

struct OnboardingNavigationTabView: View {
    
    @Environment(OnboardingViewModel.self) var onboardingViewModel
    
    var body: some View {
        HStack {
            Button {
                onboardingViewModel.isGoingForward = onboardingViewModel.onboardingState.rawValue > OnboardingState.onboardingName.rawValue
                
                onboardingViewModel.onboardingState = .onboardingName
            } label: {
                Image(systemName: onboardingViewModel.isActive(.onboardingName) ? "circle.fill" : "circle")
            }
            
            Button {
                onboardingViewModel.isGoingForward = onboardingViewModel.onboardingState.rawValue > OnboardingState.onboardingDate.rawValue
                
                onboardingViewModel.onboardingState = .onboardingDate
                
                
            } label: {
                Image(systemName: onboardingViewModel.isActive(.onboardingDate) ? "circle.fill" : "circle")
            }
            .disabled(!onboardingViewModel.isNameValid)
            
            Button {
                if onboardingViewModel.isNameValid {
                    onboardingViewModel.isGoingForward = onboardingViewModel.onboardingState.rawValue >
                    OnboardingState.onboardingDosor.rawValue
                    onboardingViewModel.onboardingState = .onboardingDosor
                }
                
            } label: {
                
                Image(systemName: onboardingViewModel.isActive(.onboardingDosor) ? "circle.fill" : "circle")
            }
            .disabled(!onboardingViewModel.isNameValid)
            
            
            Button {
                onboardingViewModel.isGoingForward = onboardingViewModel.onboardingState.rawValue >
                OnboardingState.onboardingEconomy.rawValue
                onboardingViewModel.onboardingState = .onboardingEconomy
            } label: {
                Image(systemName: onboardingViewModel.isActive(.onboardingEconomy) ? "circle.fill" : "circle")
                
            }
            .disabled(!((onboardingViewModel.numberOfDosor ?? 0) > 0))
            
            
            Button {
                onboardingViewModel.isGoingForward = onboardingViewModel.onboardingState.rawValue >
                OnboardingState.onboardingSummary.rawValue
                
                onboardingViewModel.onboardingState = .onboardingSummary
            } label: {
                Image(systemName: onboardingViewModel.isActive(.onboardingSummary) ? "circle.fill" : "circle")
                
            }
            .disabled(!((onboardingViewModel.savingGoal ?? 0) > 0))
        }
        .foregroundColor(.white)
        .background(.lightGreen)
        .padding()
    }
}

#Preview {
    OnboardingNavigationTabView()
        .environment(OnboardingViewModel())
}
