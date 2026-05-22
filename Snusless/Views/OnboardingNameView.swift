//
//  NameView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-18.
//

import SwiftUI

struct OnboardingNameView: View {
    
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    
    var onNextStep: () -> Void

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel
        
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text("Välkommen!")
                .font(.custom("Roboto-Bold", size: 26))
                .foregroundStyle(.white)
                .padding()

            Text("Vänligen skriv ditt namn för att börja")
                .font(.custom("Roboto-Bold", size: 18))
                .foregroundStyle(.white)
                .padding(.top)
                .padding(.bottom)

            TextField("Ditt namn", text: $onboardingVM.name)
                .font(.custom("Roboto-Medium", size: 16))
                .padding()
                .foregroundStyle(.white)
                .tint(.white)
                .background {
                    Color(.white.opacity(0.3))
                }
                .cornerRadius(20)
                .onChange(of: onboardingVM.name) { _, newValue in
                    let filtered = newValue.filter { $0.isLetter || $0.isWhitespace }

                    let limited = String(filtered.prefix(20))
                        onboardingVM.name = limited
                }
            
            Spacer()

            HStack {
                Spacer()
                Button {
                    Task {
                        onNextStep()
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.darkGreen)
                            .padding()
                            .background(onboardingViewModel.isNameValid ? Color.white : Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    
                }
                .disabled(!onboardingViewModel.isNameValid)
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .background(.lightGreen)
    }
}

#Preview {
    OnboardingNameView(onNextStep: {})
        .environment(OnboardingViewModel())
}
