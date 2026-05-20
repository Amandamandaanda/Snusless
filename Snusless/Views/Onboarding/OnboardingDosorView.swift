//
//  OnboardingDosorView.swift
//  Snusless
//
//  Created by Pinar Bildirici on 2026-05-19.
//


import SwiftUI

struct OnboardingDosorView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    @State private var portionCount: Double = 20.0
    @State private var dosorInput: String = ""
    
    var onNextStep: () -> Void
    var onPreviousStep: () -> Void
    
    private var isValidDosor: Bool {
        guard let dosor = Int(dosorInput) else { return false }
        return dosor > 0
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.18, green: 0.49, blue: 0.20)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Text("Onboarding 3/5")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Hur många snusdosor\nanvänder du per dag?")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    TextField("Antal", text: $dosorInput)
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
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("\(Int(portionCount))")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                    
                    Slider(value: $portionCount, in: 0...100, step: 1)
                        .accentColor(.white)
                        .padding(.horizontal, 40)
                    
                    HStack {
                        Text("0").font(.caption).foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("100").font(.caption).foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.horizontal, 40)
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
                    
                    HStack(spacing: 6) {
                        Circle().fill(Color.white.opacity(0.5)).frame(width: 6, height: 6)
                        Circle().fill(Color.white.opacity(0.5)).frame(width: 6, height: 6)
                        Circle().fill(Color.white).frame(width: 8, height: 8)
                        Circle().fill(Color.white.opacity(0.5)).frame(width: 6, height: 6)
                        Circle().fill(Color.white.opacity(0.5)).frame(width: 6, height: 6)
                    }
                    
                    Spacer()
                    
                    Text("3/5")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.trailing, 10)
                    
                    Button(action: saveAndProceed) {
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
                            .padding()
                            .background(isValidDosor ? Color.white : Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    .disabled(!isValidDosor)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }
    
    private func saveAndProceed() {
        if let dosor = Int(dosorInput) {
            viewModel.numberOfDosor = dosor
            onNextStep()
        }
    }
}
