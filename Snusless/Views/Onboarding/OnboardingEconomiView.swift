//
//  OnboardingEconomyView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import SwiftUI

struct OnboardingEconomyView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    @State private var priceInput: String = ""
    @State private var savingsGoalInput: String = ""
    
    var onNextStep: () -> Void
    var onPreviousStep: () -> Void
    
    private var isValidPrice: Bool {
        guard let price = Double(priceInput.replacingOccurrences(of: ",", with: ".")) else { return false }
        return price > 0
    }
    
    private var isValidGoal: Bool {
        guard let goal = Double(savingsGoalInput.replacingOccurrences(of: ",", with: ".")) else { return false }
        return goal > 0
    }
    
    private var canProceed: Bool {
        return isValidPrice && isValidGoal
    }
    
    var body: some View {
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
                    
                    TextField("kr", text: $priceInput)
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
                    
                    TextField("kr", text: $savingsGoalInput)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .frame(width: 140)
                }
                
                if (!priceInput.isEmpty && !isValidPrice) || (!savingsGoalInput.isEmpty && !isValidGoal) {
                    Text("Vänligen fyll i ett giltigt pris ve sparmål.")
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
                    Text("•••••  4/5").font(.caption).foregroundColor(.white.opacity(0.7))
                    Spacer()
                    Button(action: saveAndProceed) {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(canProceed ? .white : .white.opacity(0.3))
                    }
                    .disabled(!canProceed)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
    }
    
    private func saveAndProceed() {
        if let validatedPrice = Double(priceInput.replacingOccurrences(of: ",", with: ".")) {
            viewModel.pricePerDosa = validatedPrice
            onNextStep()
        }
    }
}





