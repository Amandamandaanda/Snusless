//
//  OnboardingDosorView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//

import SwiftUI

struct OnboardingDosorView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    var onNextStep: () -> Void
    var onPreviousStep: () -> Void
    
    var body: some View {
        ZStack {
            Color(.systemGreen)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Hur många snusdosor\nanvänder du per dag?")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    // Stepper för att öka/minska dosor på ett säkert sätt
                    HStack(spacing: 20) {
                        Button(action: { if viewModel.numberOfDosor > 0 { viewModel.numberOfDosor -= 1 } }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        
                        Text("\(viewModel.numberOfDosor)")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                            .frame(minWidth: 60)
                        
                        Button(action: { viewModel.numberOfDosor += 1 }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                }
                
                if viewModel.numberOfDosor == 0 {
                    Text("Antalet dosor måste vara större än 0 för att gå vidare.")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .bold()
                }
                
                Spacer()
                
                // Navigation pilar som Figma vi har //
                HStack {
                    Button(action: onPreviousStep) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("•••••  3/5")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                    Button(action: onNextStep) {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundColor(viewModel.numberOfDosor > 0 ? .white : .white.opacity(0.3))
                    }
                    .disabled(viewModel.numberOfDosor == 0)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
    }
}
