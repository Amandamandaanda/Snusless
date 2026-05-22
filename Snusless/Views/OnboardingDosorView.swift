//
//  OnboardingDosorView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//


import SwiftUI

struct OnboardingDosorView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    @State private var portionCount: Double = 20.0
    
    var onNextStep: () -> Void
    var onPreviousStep: () -> Void
    
    
    
    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel
        

        ZStack {
            Color(.green)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Hur många snusdosor\nanvänder du per dag?")
                        .font(.custom("Roboto-Bold", size: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    TextField("", value: $onboardingVM.numberOfDosor, format: .number, prompt: Text("Antal")
                        .font(.custom("Roboto-Light", size: 18)))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .frame(width: 120)
                }
                
                Spacer().frame(height: 20)
                
                VStack(spacing: 15) {
                    Text("Hur många portioner\när det i en snusdosa?")
                        .font(.custom("Roboto-Bold", size: 22))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("\(Int(onboardingViewModel.portionsPerDosa))")
                        .font(.custom("Roboto-Light", size: 20))
                        .bold()
                        .foregroundColor(.white)
                    
                    Slider(value: $portionCount, in: 0...100, step: 1)
                        .accentColor(.white)
                        .padding(.horizontal, 40)
                        .onChange(of: portionCount) {_, newValue in
                            onboardingViewModel.portionsPerDosa = Int(newValue)
                        }
                    
                    HStack {
                        Text("0")
                        Spacer()
                        Text("100")
                    }
                    .foregroundColor(.white.opacity(0.6))
                    .font(.custom("Roboto-Light", size: 14))
                    .padding(.horizontal, 40)
                }
                
                if !onboardingViewModel.errorMessage.isEmpty {
                    Text(onboardingViewModel.errorMessage)
                        .foregroundColor(.red)
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
                            .background(onboardingViewModel.isDosorValid ? Color.white : Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    .disabled(!onboardingViewModel.isDosorValid)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }
    
    private func saveAndProceed() {
        onboardingViewModel.portionsPerDosa = Int(portionCount) 
            if onboardingViewModel.errorMessage.isEmpty {
                onNextStep()
            }
    }
}

#Preview {
    OnboardingDosorView(onNextStep: {}, onPreviousStep: {})
        .environment(OnboardingViewModel())
}

