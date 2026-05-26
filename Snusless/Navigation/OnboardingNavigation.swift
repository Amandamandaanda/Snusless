//
//  OnboardingView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-19.
//

import SwiftUI
import SwiftData

struct OnboardingNavigation: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    @Environment(\.modelContext) private var modelContext
    
    @Binding var selectedTab: TabSelection
    
    @State private var isGoingForward: Bool = false
    
    var body: some View {
        VStack {
            switch onboardingViewModel.onboardingState {
            case .onboardingName:
                OnboardingNameView(onNextStep: {
                    isGoingForward = true
                    onboardingViewModel.onboardingState = .onboardingDate
                })
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading).combined(with: .opacity), removal: .move(edge: isGoingForward ? .leading : .trailing).combined(with: .opacity)))
            case .onboardingDate:
                OnboardingDateView(onNextStep: {
                    isGoingForward = true
                    onboardingViewModel.onboardingState = .onboardingDosor
                    
                }, onPreviousStep: {
                    isGoingForward = false
                    onboardingViewModel.onboardingState = .onboardingName
                })
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading).combined(with: .opacity), removal: .move(edge: isGoingForward ? .leading : .trailing).combined(with: .opacity)))
                    
           
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
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading).combined(with: .opacity), removal: .move(edge: isGoingForward ? .leading : .trailing).combined(with: .opacity)))
                
       
            case .onboardingEconomy:
                @Bindable var onboardingVM = onboardingViewModel
                OnboardingEconomyView(
                    onNextStep: {

                        isGoingForward = true
                        onboardingViewModel.onboardingState = .onboardingSummary


                    },
                    onPreviousStep: {
                        isGoingForward = false
                        onboardingViewModel.onboardingState = .onboardingDosor
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading).combined(with: .opacity), removal: .move(edge: isGoingForward ? .leading : .trailing).combined(with: .opacity)))
                
            case .onboardingSummary:
                @Bindable var onboardingVM = onboardingViewModel
                OnboardingSummaryView(saveUser: {
                    onboardingViewModel.saveUser(context: modelContext)
                    selectedTab = .home
                    
                }, onPreviousStep: {
                    isGoingForward = false
                    onboardingViewModel.onboardingState = .onboardingEconomy
                })
                .transition(.asymmetric(insertion: .move(edge: isGoingForward ? .trailing : .leading).combined(with: .opacity), removal: .move(edge: isGoingForward ? .leading : .trailing).combined(with: .opacity)))
                 
                
            case .onboardingDone:
                RootNavigation(selectedTab: $selectedTab)
                    .transition(.scale)
                
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
                    .disabled(!((onboardingViewModel.numberOfDosor ?? 0) > 0))
                    
                    
                    Button {
                        isGoingForward = onboardingViewModel.onboardingState.rawValue >
                        OnboardingState.onboardingSummary.rawValue
                        
                        onboardingViewModel.onboardingState = .onboardingSummary
                    } label: {
                        Image(systemName: isActive(.onboardingSummary) ? "circle.fill" : "circle")
                            
                    }
                    .disabled(!((onboardingViewModel.savingGoal ?? 0) > 0))
                }
                .foregroundColor(.white)
                .background(.lightGreen)
                .padding()
            }
            
        }
        .background(.lightGreen)
        .animation(.smooth(duration: 0.3), value: onboardingViewModel.onboardingState)
    }
    
    private func isActive(_ state: OnboardingState) -> Bool {
        onboardingViewModel.onboardingState == state
    }
    
}

#Preview {
    OnboardingNavigation(selectedTab: .constant(.home))
        .environment(OnboardingViewModel())
}
