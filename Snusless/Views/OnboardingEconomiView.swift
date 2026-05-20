//
//  OnboardingEconomyView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import SwiftUI

struct OnboardingEconomyView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    
    var onNextStep: () -> Void
    var onPreviousStep: () -> Void
    
    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel
        
        ZStack {
            Color(.systemGreen)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                VStack(spacing: 12) {
                    Text("Vad kostar en\nsnusdosa?")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    TextField("kr", value: $onboardingVM.pricePerDosa, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .frame(width: 140)
                }
                
                VStack(spacing: 12) {
                    Text("Sparmål")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    TextField("kr", value: $onboardingVM.savingGoal, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .frame(width: 140)
                }
                
                if !onboardingViewModel.errorMessage.isEmpty {
                    Text(onboardingViewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                if (!onboardingViewModel.isValidPrice && onboardingViewModel.pricePerDosa > 0) ||
                   (!onboardingViewModel.isValidGoal && onboardingViewModel.savingGoal > 0) {
                    Text("Vänligen fyll i ett giltigt pris och sparmål.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                HStack {
                    Button(action: onPreviousStep) {
                        Image(systemName: "arrow.left").font(.title2).foregroundColor(.white)
                    }
                    Spacer()
                    
                    Button(action: saveAndProceed) {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(onboardingViewModel.canProceed ? .white : .white.opacity(0.3))
                    }
                    .disabled(!onboardingViewModel.canProceed)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
    }
    
    private func saveAndProceed() {
        if onboardingViewModel.isValidPrice {
            if onboardingViewModel.errorMessage.isEmpty {
                onNextStep()
            }
        }
    }
}





