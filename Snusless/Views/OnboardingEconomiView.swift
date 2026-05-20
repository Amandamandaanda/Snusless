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
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    
                    Button(action: saveAndProceed) {
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                            .padding()
                            .background(onboardingViewModel.isValidPrice ? Color.white : Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    .disabled(!onboardingViewModel.canProceed)
                }
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 20)
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





