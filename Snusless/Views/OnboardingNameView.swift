//
//  NameView.swift
//  Snusless
//
//  Created by Jonathan Strid on 2026-05-18.
//

import SwiftUI

struct OnboardingNameView: View {
    
    @Environment(OnboardingViewModel.self) private var onboardingViewModel

    var body: some View {
        @Bindable var onboardingVM = onboardingViewModel
        
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text("Välkommen!")
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .padding()

            Text("Vänligen skriv ditt namn för att börja")
                .font(.title3)
                .foregroundStyle(.white)
                .bold()
                .padding(.top)
                .padding(.bottom)

            TextField("Ditt namn", text: $onboardingVM.name)
                .bold()
                .padding()
                .foregroundStyle(.white)
                .tint(.white)
                .background {
                    Color(.gray.opacity(0.5))
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
                        onboardingViewModel.onboardingState = .onboardingDate
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(red: 0.18, green: 0.49, blue: 0.20))
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
        .background(.green)
    }
}

#Preview {
    OnboardingNameView()
        .environment(OnboardingViewModel())
}
