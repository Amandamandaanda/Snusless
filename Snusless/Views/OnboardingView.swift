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
    
    @State private var isGoingForward: Bool = false
    
    var body: some View {
        VStack {
            switch onboardingViewModel.onboardingState {
            case .onboardingName:
                OnboardingNameView(onNextStep: {
                    isGoingForward = true
                    onboardingViewModel.onboardingState = .onboardingDate
                })
                    .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading), removal: .move(edge: isGoingForward ? .leading : .trailing)))
            case .onboardingDate:
                OnboardingDateView(onNextStep: {
                    isGoingForward = true
                    onboardingViewModel.onboardingState = .onboardingDosor
                    
                }, onPreviousStep: {
                    isGoingForward = false
                    onboardingViewModel.onboardingState = .onboardingName
                })
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading), removal: .move(edge: isGoingForward ? .leading : .trailing)))
                    
           
            case .onboardingDosor:
                @Bindable var onboardingVM = onboardingViewModel
                OnboardingDosorView(
                    onNextStep: {
                        isGoingForward = true
                        onboardingViewModel.onboardingState = .onboardingEconomy
                    },
                    onPreviousStep: {
                        isGoingForward = false
                        onboardingViewModel.onboardingState = .onboardingDate
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading), removal: .move(edge: isGoingForward ? .leading : .trailing)))
                
       
            case .onboardingEconomy:
                @Bindable var onboardingVM = onboardingViewModel
                OnboardingEconomyView(
                    onNextStep: {
                        isGoingForward = true
                        onboardingViewModel.onboardingState = .onboardingDone
                        onboardingViewModel.saveUser(context: modelContext)
                    },
                    onPreviousStep: {
                        isGoingForward = false
                        onboardingViewModel.onboardingState = .onboardingDosor
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading), removal: .move(edge: isGoingForward ? .leading : .trailing)))
                
            case .onboardingDone:
                HomeView()
                    .transition(.move(edge: .trailing))
                
            }

            if onboardingViewModel.onboardingState != .onboardingDone {
                HStack {
                    Button {
                        isGoingForward = onboardingViewModel.onboardingState.rawValue > OnboardingState.onboardingName.rawValue

                        onboardingViewModel.onboardingState = .onboardingName
                    } label: {
                        Image(systemName: isActive(.onboardingName) ? "circle.fill" : "circle")
                    }
                    
                    Button {
                        isGoingForward = onboardingViewModel.onboardingState.rawValue > OnboardingState.onboardingDate.rawValue
                        
                            onboardingViewModel.onboardingState = .onboardingDate
                        
                        
                    } label: {
                        Image(systemName: isActive(.onboardingDate) ? "circle.fill" : "circle")
                    }
                    .disabled(!onboardingViewModel.isNameValid)
                    
                    Button {
                        if onboardingViewModel.isNameValid {
                            isGoingForward = onboardingViewModel.onboardingState.rawValue >
                            OnboardingState.onboardingDosor.rawValue
                            onboardingViewModel.onboardingState = .onboardingDosor
                        }
                      
                    } label: {
                        
                        Image(systemName: isActive(.onboardingDosor) ? "circle.fill" : "circle")
                    }
                    .disabled(!onboardingViewModel.isNameValid)
                    
                    
                    Button {
                        isGoingForward = onboardingViewModel.onboardingState.rawValue >
                        OnboardingState.onboardingEconomy.rawValue
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
