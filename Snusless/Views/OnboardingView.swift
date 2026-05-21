//
//  OnboardingView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-19.
//

import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            switch onboardingViewModel.onboardingState {
            case .onboardingName:
                OnboardingNameView()
                    .transition(.move(edge: .leading))
            case .onboardingDate:
                OnboardingDateView()
                    .transition(.move(edge: .trailing))
                    
           
            case .onboardingDosor:
                @Bindable var onboardingVM = onboardingViewModel
                OnboardingDosorView(
                    onNextStep: {
                        onboardingViewModel.onboardingState = .onboardingEconomy
                    },
                    onPreviousStep: {
                        onboardingViewModel.onboardingState = .onboardingDate
                    }
                )
                .transition(.move(edge: .trailing))
                
       
            case .onboardingEconomy:
                @Bindable var onboardingVM = onboardingViewModel
                OnboardingEconomyView(
                    onNextStep: {
                        onboardingViewModel.onboardingState = .onboardingSummary
                    },
                    onPreviousStep: {
                        onboardingViewModel.onboardingState = .onboardingDosor
                    }
                )
                .transition(.move(edge: .trailing))
                
            case .onboardingSummary:
                OnboardingSummaryView()
                    .transition(.move(edge: .trailing))
                
            case .onboardingDone:
                HomeView()
                    .transition(.move(edge: .trailing))
                
            }

            if onboardingViewModel.onboardingState != .onboardingDone && onboardingViewModel.onboardingState != .onboardingSummary {
                HStack {
                    Button {
                        
                        onboardingViewModel.onboardingState = .onboardingName
                    } label: {
                        Image(systemName: isActive(.onboardingName) ? "circle.fill" : "circle")
                    }
                    
                    Button {
                            onboardingViewModel.onboardingState = .onboardingDate
                        
                        
                    } label: {
                        Image(systemName: isActive(.onboardingDate) ? "circle.fill" : "circle")
                    }
                    .disabled(!onboardingViewModel.isNameValid)
                    
                    Button {
                        if onboardingViewModel.isNameValid {
                            onboardingViewModel.onboardingState = .onboardingDosor
                        }
                      
                    } label: {
                        
                        Image(systemName: isActive(.onboardingDosor) ? "circle.fill" : "circle")
                    }
                    .disabled(!onboardingViewModel.isNameValid)
                    
                    
                    Button {
                        onboardingViewModel.onboardingState = .onboardingEconomy
                    } label: {
                        Image(systemName: isActive(.onboardingEconomy) ? "circle.fill" : "circle")
                            
                    }
                    .disabled(!(onboardingViewModel.numberOfDosor > 0))
                }
                .foregroundColor(.white)
                .background(.green)
                .padding()
            }
            
        }
        .background(.green)
        .animation(.smooth(duration: 0.3), value: onboardingViewModel.onboardingState)
    }
    
    private func isActive(_ state: OnboardingState) -> Bool {
        onboardingViewModel.onboardingState == state
    }
}

#Preview {
    OnboardingView()
        .environment(OnboardingViewModel())
}
