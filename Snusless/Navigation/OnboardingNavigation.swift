//
//  OnboardingView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-19.
//

import SwiftUI
import SwiftData

struct OnboardingNavigation: View {
    @Environment(OnboardingViewModel.self) var onboardingViewModel
    @Environment(\.modelContext) private var modelContext
    
    
    
    
    var body: some View {
        VStack {
            switch onboardingViewModel.onboardingState {
            case .onboardingName:
                OnboardingNameView(onNextStep: {
                    onboardingViewModel.isGoingForward = true
                    onboardingViewModel.onboardingState = .onboardingDate
                })
                .transition(slideTransition(isGoingForward: onboardingViewModel.isGoingForward))

            case .onboardingDate:
                OnboardingDateView(onNextStep: {
                    onboardingViewModel.isGoingForward = true
                    onboardingViewModel.onboardingState = .onboardingDosor
                    
                }, onPreviousStep: {
                    onboardingViewModel.isGoingForward = false
                    onboardingViewModel.onboardingState = .onboardingName
                })
                .transition(slideTransition(isGoingForward: onboardingViewModel.isGoingForward))
                    
           
            case .onboardingDosor:
                OnboardingDosorView(
                    onNextStep: {
                        onboardingViewModel.isGoingForward = true
                        onboardingViewModel.onboardingState = .onboardingEconomy
                    },
                    onPreviousStep: {
                        onboardingViewModel.isGoingForward = false
                        onboardingViewModel.onboardingState = .onboardingDate
                    }
                )
                .transition(slideTransition(isGoingForward: onboardingViewModel.isGoingForward))

                
       
            case .onboardingEconomy:
                OnboardingEconomyView(
                    onNextStep: {

                        onboardingViewModel.isGoingForward = true
                        onboardingViewModel.onboardingState = .onboardingSummary


                    },
                    onPreviousStep: {
                        onboardingViewModel.isGoingForward = false
                        onboardingViewModel.onboardingState = .onboardingDosor
                    }
                )
                .transition(slideTransition(isGoingForward: onboardingViewModel.isGoingForward))

                
            case .onboardingSummary:
                OnboardingSummaryView(saveUser: {
                    onboardingViewModel.saveUser(context: modelContext)
                    
                    
                }, onPreviousStep: {
                    onboardingViewModel.isGoingForward = false
                    onboardingViewModel.onboardingState = .onboardingEconomy
                })
                .transition(slideTransition(isGoingForward: onboardingViewModel.isGoingForward))

                 
                
            case .onboardingDone:
                RootNavigation()
                    .transition(.scale)
                
            }

            if onboardingViewModel.onboardingState != .onboardingDone {
                OnboardingNavigationTabView()
            }
            
        }
        .background(.lightGreen)
        .animation(.smooth(duration: 0.3), value: onboardingViewModel.onboardingState)
    }
    
}

#Preview {
    OnboardingNavigation()
        .environment(OnboardingViewModel())
}
